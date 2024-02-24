var config = require("../../config/db");
const constants = require("../../config/constants");
var db = config.getConnection;
var dbPromise = config.getPromiseConnection;
var jwt = require("jsonwebtoken");
const moment = require("moment");
const { now, max } = require("moment");

module.exports = {
  getAllCategories: (data, callback) => {
    db(function (err, connection) {
      if (err) {
        return callback({ code: 500, error: err });
      } else {
        connection.query(
          "SELECT *,concat('" +
            constants.CATEGORY_URL +
            "',category_image) as category_image FROM categories ORDER BY category_name ASC",
          function (err, results) {
            if (err) {
              connection.release();
              return callback({ code: 500, error: err });
            } else {
              connection.release();
              return callback(null, {
                code: 200,
                message: "Categories list fetched successfully",
                data: results,
              });
            }
          }
        );
      }
    });
  },

  saveMyCategories: (data, callback) => {
    const consumerId = data.consumer_id;
    const selectedCategories = data.selected_categories;
    const nowTime = moment().utc().format("YYYY-MM-DD HH:mm:ss");

    dbPromise(async function (err, connection) {
      if (err) {
        return callback({ code: 500, error: err });
      } else {
        try {
          await connection.beginTransaction();

          selectedCategories.forEach(async (category) => {
            const categoryId = category.category_id;
            const pricePerUnit = category.price_per_unit;

            const categoryData = {
              consumer_id: consumerId,
              category_id: categoryId,
              price_per_unit: pricePerUnit,
              created_at: nowTime,
              updated_at: nowTime,
            };

            const [consumerCategory] = await connection.query(
              "SELECT * FROM consumer_categories WHERE consumer_id=" +
                consumerId +
                " AND category_id=" +
                categoryId
            );

            if (consumerCategory == null || consumerCategory.length == 0) {
              const [] = await connection.query(
                "INSERT INTO consumer_categories SET ?",
                categoryData
              );
            } else {
              const [] = await connection.query(
                "UPDATE consumer_categories SET price_per_unit=?,updated_at=? WHERE consumer_id=" +
                  consumerId +
                  " AND category_id=" +
                  categoryId,
                [pricePerUnit, nowTime]
              );
            }
          });
          connection.commit();
          return callback(null, {
            code: 200,
            message: "Categories saved successfully",
            data: null,
          });
        } catch (error) {
          if (connection) await connection.rollback();
          return callback({ code: 500, error: error });
        } finally {
          if (connection) await connection.release();
        }
      }
    });
  },

  getMyDashboard: (data, callback) => {
    const consumerId = data.consumer_id;
    // const categoryIds=data.category_ids;
    const todayDate = moment().utc().format("YYYY-MM-DD");
    const lastMonth = moment()
      .subtract(1, "month")
      .utc()
      .format("YYYY-MM-DD hh:mm:ss");

    dbPromise(async function (err, connection) {
      if (err) {
        return callback({ code: 500, error: err });
      } else {
        const [categoriesIds] = await connection.query(
          "SELECT category_id FROM consumer_categories WHERE consumer_id=" +
            consumerId
        );

        var categoryIds = [];

        categoriesIds.forEach((element) => {
          categoryIds.push(element.category_id);
        });

        const [total_weight] = await connection.query(
          "SELECT COALESCE(sum(total_weight),0) as total_weight FROM pickup_locations WHERE consumer_id=" +
            consumerId +
            " AND pickup_status=1"
        );

        const [pickups] = await connection.query(
          "SELECT id,pickup_date,total_weight,total_location FROM dustbin_pickups WHERE consumer_id=" +
            consumerId +
            " AND pickup_status=0"
        );

        const [dayWiseWaste] = await connection.query(
          "SELECT DATE_FORMAT(pickup_date,'%d %M') as date, COALESCE(sum(total_weight),0) as total_weight FROM dustbin_pickups WHERE consumer_id=" +
            consumerId +
            " GROUP BY pickup_date ORDER BY pickup_date DESC LIMIT 7"
        );

        const [monthlyCategoryDistribution] = await connection.query(
          "SELECT COALESCE(sum(pickup_locations.total_weight),0) as total_weight,categories.category_name FROM pickup_locations LEFT JOIN categories ON pickup_locations.category_id=categories.id WHERE pickup_locations.pickup_status=1 AND pickup_locations.consumer_id=" +
            consumerId +
            " AND pickup_locations.created_at>='" +
            lastMonth +
            "' GROUP BY pickup_locations.category_id"
        );

        const responseData = {
          total_weight: total_weight[0].total_weight,
          pickups: pickups,
          day_wise_waste: dayWiseWaste,
          monthly_category_distribution: monthlyCategoryDistribution,
        };

        connection.release();
        return callback(null, {
          code: 200,
          message: "Dashboard details fetched successfully",
          data: responseData,
        });
      }
    });
  },

  getWastePrediction: (data, callback) => {
    const consumerId = data.consumer_id;
    const categoryIds = data.category_ids;

    dbPromise(async function (err, connection) {
      if (err) {
        return callback({ code: 500, error: err });
      } else {
        const [consumer] = await connection.query(
          "SELECT * FROM consumer_user WHERE id=" + consumerId
        );

        const consumerLat = consumer[0].lat;
        const consumerLng = consumer[0].lng;

        const [inRangeDustbins] = await connection.query(
          "SELECT dustbins.*,round(( 6371 * ACOS( COS( RADIANS( producer_user.lat ) ) * COS( RADIANS('" +
            consumerLat +
            "') ) * COS( RADIANS('" +
            consumerLng +
            "') - RADIANS( producer_user.lng ) ) + SIN( RADIANS( producer_user.lat ) ) * SIN( RADIANS('" +
            consumerLat +
            "') ) ) ),2)AS distance FROM dustbins LEFT JOIN producer_user ON dustbins.producer_id=producer_user.id WHERE dustbins.category_id in (?) AND dustbins.current_depth<20 AND dustbins.dustbin_status=1 HAVING distance<=20000",
          [categoryIds]
        );

        console.log(inRangeDustbins);

        var inRangeDustbinIds = [];

        inRangeDustbins.forEach((inRangeDustbin) => {
          inRangeDustbinIds.push(inRangeDustbin.id);
        });

        if (inRangeDustbinIds.length == 0) {
          connection.release();
          return callback(null, {
            code: 300,
            message: "No dustbin in range",
            data: null,
          });
        }

        console.log(inRangeDustbinIds);

        var predictions = [];

        var nextWeek = [];

        for (let i = 1; i <= 7; i++) {
          nextWeek.push(moment().add(i, "days").utc().format("YYYY-MM-DD"));
        }

        console.log(nextWeek);

        for (let day of nextWeek) {
          var finalDustbinIds = [];

          let totalWeightSum = 0;
          for (let db_id of inRangeDustbinIds) {
            var [lastPickupDustbin] = await connection.query(
              "SELECT dustbin_id, max(DATE_FORMAT(to_date,'%Y-%m-%d')) as max_date FROM pickup_locations WHERE dustbin_id =? GROUP BY dustbin_id",
              [db_id]
            );

            console.log(lastPickupDustbin.length);

            if (lastPickupDustbin.length > 0) {
              var lastPickup = lastPickupDustbin[0];

              console.log("Last pickup ", lastPickup, day);
              var [dayWiseDustbinOne] = await connection.query(
                "SELECT dustbin_id FROM pickup_locations WHERE dustbin_id=? AND to_date=? AND pickup_status=1 LIMIT 1",
                [lastPickup.dustbin_id, lastPickup.max_date]
              );
              console.log("Day wise one", dayWiseDustbinOne);
              var [dayWiseDustbinZero] = await connection.query(
                "SELECT dustbin_id FROM pickup_locations WHERE dustbin_id=? AND to_date=? AND pickup_status=0 LIMIT 1",
                [lastPickup.dustbin_id, lastPickup.max_date]
              );

              var fromDatePrediction = "";

              console.log(dayWiseDustbinOne);
              console.log(dayWiseDustbinZero);

              console.log("Day wise zero", dayWiseDustbinZero);

              if (dayWiseDustbinZero.length > 0) {
                const zeroDustbinId = dayWiseDustbinZero[0].dustbin_id;

                const [zeroDustbin] = await connection.query(
                  "SELECT current_capacity, DATE_FORMAT(updated_at,'%y-%m-%d') as date FROM dustbins WHERE id=" +
                    zeroDustbinId
                );

                // totalWeightSum += zeroDustbin[0].current_capacity;

                fromDatePrediction = moment(zeroDustbin[0].date, "YYYY-MM-DD")
                  .utc()
                //   .subtract(1, "days")
                  .format("YYY-MM-DD");

                finalDustbinIds.push(zeroDustbinId);
              } else if (dayWiseDustbinOne.length > 0) {
                fromDatePrediction = lastPickup.max_date;
                finalDustbinIds.push(dayWiseDustbinOne[0].dustbin_id);
              }

              const [predictionData] = await connection.query(
                "SELECT sum(predicted_weight) as predicted_weight FROM dustbin_predictions WHERE date>? AND date<=? AND dustbin_id=?",
                [fromDatePrediction, day, lastPickup.dustbin_id]
              );

              console.log(
                "Predicted data",
                predictionData,
                fromDatePrediction,
                day
              );

              totalWeightSum += predictionData[0].predicted_weight;

              console.log("In IF ",db_id,day, totalWeightSum);
            }else{
                const [db_dustbin] = await connection.query(
                    "SELECT DATE_FORMAT(created_at,'%y-%m-%d') as date FROM dustbins WHERE id=" +
                      db_id
                  );
                  const fromDate = db_dustbin[0].date;
    
                  const [predictionData] = await connection.query(
                    "SELECT sum(predicted_weight) as predicted_weight FROM dustbin_predictions WHERE date>? AND date<=? AND dustbin_id=?",
                    [fromDate, day, db_id]
                  );
    
                  totalWeightSum += predictionData[0].predicted_weight;
                  finalDustbinIds.push(db_id);
    
                  console.log("In Else ",db_id,day, totalWeightSum);
            }
          }

          console.log("Total weifht sum", totalWeightSum);

          var selectedProducers = [];
          var selectedCategories = [];

          if (finalDustbinIds.length > 0) {
            const [dustbinProducerCategory] = await connection.query(
              "SELECT dustbins.producer_id,categories.category_name FROM dustbins LEFT JOIN categories ON dustbins.category_id=categories.id WHERE dustbins.id IN (?)",
              [finalDustbinIds]
            );

            console.log(dustbinProducerCategory);

            dustbinProducerCategory.forEach((dpc) => {
              if (!selectedProducers.includes(dpc.producer_id)) {
                selectedProducers.push(dpc.producer_id);
              }
              if (!selectedCategories.includes(dpc.category_name)) {
                selectedCategories.push(dpc.category_name);
              }
            });

            console.log(selectedProducers);
            console.log(selectedCategories);
          }

          const prediction = {
            date: day,
            predicted_weight: totalWeightSum,
            selected_dustbin_ids: finalDustbinIds,
            selected_producers: selectedProducers,
            selected_categories_name: selectedCategories,
          };

          predictions.push(prediction);
        }

        connection.release();
        return callback(null, {
          code: 200,
          message: "Waste prediction fetched successfully",
          data: predictions,
        });
      }
    });
  },

  getPreOrderSummary: (data, callback) => {
    const consumerId = data.consumer_id;
    const categoryIds = data.category_ids;
    const dustbinIds = data.dustbin_ids;
    const date = data.date;

    dbPromise(async function (err, connection) {
      if (err) {
        return callback({ code: 500, error: err });
      } else {

        var categorisedData=[];

        for(let categoryId of categoryIds){

            let totalWeightSum=0;
            for(let dustbinId of dustbinIds){
                const [maxDate]=await connection.query("SELECT dustbin_id, max(DATE_FORMAT(to_date,'%Y-%m-%d')) as max_date FROM pickup_locations WHERE dustbin_id =? AND category_id=?",[dustbinId,categoryId]);

                var fromDate="";
                if(maxDate.length>0){
                    fromDate=maxDate[0].max_date;
                }else{
                    const [dust]=await connection.query("SELECT DATE_FORMAT(created_at,'%y-%m-%d') as date FROM dustbins WHERE id="+dustbinId+" AND category_id="+categoryId);
                    fromDate=dust[0].date;
                }

                const [predictionData] = await connection.query(
                    "SELECT sum(predicted_weight) as predicted_weight FROM dustbin_predictions WHERE date>? AND date<=? AND dustbin_id=? AND category_id=?",
                    [fromDate, date, dustbinId,categoryId]
                  );

                  totalWeightSum += predictionData[0].predicted_weight;

                  console.log(totalWeightSum);
            }

            const [categories]=await connection.query("SELECT category_name FROM categories WHERE id="+categoryId);
            const category=categories[0];

            const [consumerCategories]=await connection.query("SELECT price_per_unit FROM consumer_categories WHERE category_id="+categoryId);
            const consumerCategory=consumerCategories[0];

            const categoryWiseData={
                category_id:categoryId,
                category_name:category.category_name,
                price_per_unit:consumerCategory.price_per_unit,
                total_weight:totalWeightSum
            }

            categorisedData.push(categoryWiseData);
        }
    

        connection.release();
        return callback(null, {
          code: 200,
          message: "Pre order summary fetched successfully",
          data: categorisedData,
        });
      }
    });
  },

  getAllActivities: (data, callback) => {
    const consumerId = data.consumer_id;
    const fromId = data.from_id;
    const maxCount = 20;

    db(function (err, connection) {
      if (err) {
        return callback({ code: 500, error: err });
      } else {
        var sql = "";

        if (fromId == 0) {
          sql =
            "SELECT * FROM consumer_activities WHERE consumer_id=" +
            consumerId +
            " ORDER BY id DESC LIMIT " +
            maxCount;
        } else {
          sql =
            "SELECT * FROM consumer_activities WHERE consumer_id=" +
            consumerId +
            " AND id<" +
            fromId +
            " ORDER BY id DESC LIMIT " +
            maxCount;
        }

        connection.query(sql, function (err, results) {
          if (err) {
            connection.release();
            return callback({ code: 500, error: err });
          } else {
            connection.release();
            return callback(null, {
              code: 200,
              message: "Consumer activities fetched successfully",
              data: results,
            });
          }
        });
      }
    });
  },

  getMyCategories: (data, callback) => {
    const consumerId = data.consumer_id;

    db(function (err, connection) {
      if (err) {
        return callback({ code: 500, error: err });
      } else {
        connection.query(
          "SELECT categories.category_name,concat('" +
            constants.CATEGORY_URL +
            "',categories.category_image) as category_image,consumer_categories.category_id,consumer_categories.price_per_unit FROM consumer_categories LEFT JOIN categories ON consumer_categories.category_id=categories.id WHERE consumer_id=" +
            consumerId,
          function (err, results) {
            if (err) {
              connection.release();
              return callback({ code: 500, error: err });
            } else {
              connection.release();
              return callback(null, {
                code: 200,
                message: "Consumer categories fetched successfully",
                data: results,
              });
            }
          }
        );
      }
    });
  },

  getAllNotifications: (data, callback) => {
    const consumerId = data.consumer_id;
    const fromId = data.from_id;
    const maxCount = 20;

    db(function (err, connection) {
      if (err) {
        return callback({ code: 500, error: err });
      } else {
        var sql = "";

        if (fromId == 0) {
          sql =
            "SELECT * FROM consumer_notifications WHERE consumer_id=" +
            consumerId +
            " ORDER BY id DESC LIMIT " +
            maxCount;
        } else {
          sql =
            "SELECT * FROM consumer_notifications WHERE consumer_id=" +
            consumerId +
            " AND id<" +
            fromId +
            " ORDER BY id DESC LIMIT " +
            maxCount;
        }

        connection.query(sql, function (err, results) {
          if (err) {
            connection.release();
            return callback({ code: 500, error: err });
          } else {
            connection.release();
            return callback(null, {
              code: 200,
              message: "Consumer notification fetched successfully",
              data: results,
            });
          }
        });
      }
    });
  },

  getMyProfile: (data, callback) => {
    const consumerId = data.consumer_id;

    db(function (err, connection) {
      if (err) {
        return callback({ code: 500, error: err });
      } else {
        connection.query(
          "SELECT *,concat('" +
            constants.CONSUMER_PROFILE +
            "',consumer_profile) as consumer_profile FROM consumer_user WHERE id=" +
            consumerId,
          function (err, results) {
            if (err) {
              connection.release();
              return callback({ code: 500, error: err });
            } else {
              connection.release();
              return callback(null, {
                code: 200,
                message: "My Profile fetched successfully",
                data: results,
              });
            }
          }
        );
      }
    });
  },

  updateProfile: (data, callback) => {
    const consumerId = data.consumer_id;
    const consumerName = data.consumer_name;
    const consumerAddress = data.consumer_address;
    const profile = data.profile;

    var updateData;

    if (profile == "") {
      updateData = {
        consumer_name: consumerName,
        consumer_address: consumerAddress,
      };
    } else {
      updateData = {
        consumer_name: consumerName,
        consumer_address: consumerAddress,
        consumer_profile: profile,
      };
    }

    db(function (err, connection) {
      if (err) {
        return callback({ code: 500, error: err });
      } else {
        connection.query(
          "UPDATE consumer_user SET ? WHERE id=" + consumerId,
          updateData,
          function (err, results) {
            if (err) {
              connection.release();
              return callback({ code: 500, error: err });
            } else {
              connection.release();
              return callback(null, {
                code: 200,
                message: "Consumer profile updated successfully",
                data: null,
              });
            }
          }
        );
      }
    });
  },

  getMyTags: (data, callback) => {
    const consumerId = data.consumer_id;

    db(function (err, connection) {
      if (err) {
        return callback({ code: 500, error: err });
      } else {
        connection.query(
          "SELECT tags.tag_name,consumer_tags.tag_id FROM consumer_tags LEFT JOIN tags ON consumer_tags.tag_id=tags.id WHERE consumer_tags.consumer_id=" +
            consumerId +
            " AND tags.tag_status=1",
          function (err, results) {
            if (err) {
              connection.release();
              return callback({ code: 500, error: err });
            } else {
              connection.release();
              return callback(null, {
                code: 200,
                message: "Consumer tags fetched successfully",
                data: results,
              });
            }
          }
        );
      }
    });
  },

  updateMyTags: (data, callback) => {
    const consumerId = data.consumer_id;
    const tagIds = data.tag_ids;

    dbPromise(async function (err, connection) {
      if (err) {
        return callback({ code: 500, error: err });
      } else {
        try {
          await connection.beginTransaction();

          const [] = await connection.query(
            "DELETE FROM consumer_tags WHERE consumer_id=" + consumerId
          );

          tagIds.forEach(async (element) => {
            const tagData = {
              consumer_id: consumerId,
              tag_id: element,
            };

            const [] = await connection.query(
              "INSERT INTO consumer_tags SET ?",
              tagData
            );
          });
          connection.commit();
          return callback(null, {
            code: 200,
            message: "Tags updated successfully",
            data: null,
          });
        } catch (error) {
          if (connection) await connection.rollback();
          return callback({ code: 500, error: error });
        } finally {
          if (connection) await connection.release();
        }
      }
    });
  },

  updateMyCategories: (data, callback) => {
    const consumerId = data.consumer_id;
    const selectedCategories = data.selected_categories;
    const nowTime = moment().utc().format("YYYY-MM-DD HH:mm:ss");

    dbPromise(async function (err, connection) {
      if (err) {
        return callback({ code: 500, error: err });
      } else {
        try {
          await connection.beginTransaction();

          const [] = await connection.query(
            "DELETE FROM consumer_categories WHERE consumer_id=" + consumerId
          );

          selectedCategories.forEach(async (category) => {
            const categoryId = category.category_id;
            const pricePerUnit = category.price_per_unit;

            const categoryData = {
              consumer_id: consumerId,
              category_id: categoryId,
              price_per_unit: pricePerUnit,
              created_at: nowTime,
              updated_at: nowTime,
            };

            const [consumerCategory] = await connection.query(
              "SELECT * FROM consumer_categories WHERE consumer_id=" +
                consumerId +
                " AND category_id=" +
                categoryId
            );

            if (consumerCategory == null || consumerCategory.length == 0) {
              const [] = await connection.query(
                "INSERT INTO consumer_categories SET ?",
                categoryData
              );
            } else {
              const [] = await connection.query(
                "UPDATE consumer_categories SET price_per_unit=?,updated_at=? WHERE consumer_id=" +
                  consumerId +
                  " AND category_id=" +
                  categoryId,
                [pricePerUnit, nowTime]
              );
            }
          });
          connection.commit();
          return callback(null, {
            code: 200,
            message: "Categories updated successfully",
            data: null,
          });
        } catch (error) {
          if (connection) await connection.rollback();
          return callback({ code: 500, error: error });
        } finally {
          if (connection) await connection.release();
        }
      }
    });
  },

  getAllTags: (data, callback) => {
    db(function (err, connection) {
      if (err) {
        return callback({ code: 500, error: err });
      } else {
        connection.query(
          "SELECT id,tag_name FROM tags WHERE tag_status=1",
          function (err, results) {
            if (err) {
              connection.release();
              return callback({ code: 500, error: err });
            } else {
              connection.release();
              return callback(null, {
                code: 200,
                message: "Tags fetched succesfully",
                data: results,
              });
            }
          }
        );
      }
    });
  },
};
