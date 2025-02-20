# Tool must be specified
test_that("No tool specified", {
  expect_error(rob_summary(data_rob2))
  expect_error(rob_traffic_light(data_rob2))
})

test_that("Tool specified incorrectly", {
  expect_error(rob_summary(data_rob2, "Rob2"))
  expect_error(rob_traffic_light(data_rob2, "Rob2"))
})


test_that("ROB1 gives message", {
  expect_message(rob_summary(data_rob1, "ROB1"))
  expect_message(rob_traffic_light(data_rob1, "ROB1"))
})

test_that("Colour errors", {
          expect_error(rob_summary(data_rob2, "ROB2", colour = c("#FFFFFF")))
          expect_error(rob_traffic_light(data_robins_i,"ROBINS-I", colour = c("#FFFFFF")))
})

test_sum <- data_rob2[, c(1:6)]
test_tf <- data_rob2[, c(1:6)]

test_that("Too few columns", {
  expect_error(rob_summary(test_sum, "ROB2"))
  expect_error(rob_traffic_light(test_tf, "ROB2"))
})

test_sum <- data_robins_i[, c(1:8)]
test_tf <- data_robins_i[, c(1:8)]

test_that("Too few columns", {
  expect_error(rob_summary(test_sum, "ROBINS-I"))
  expect_error(rob_traffic_light(test_tf, "ROBINS-I"))
  expect_error(rob_traffic_light(data_rob2[, 1:7], tool = "ROB2-Cluster"))
})

test_sum <- data_quadas[, c(1:6)]
test_tf <- data_quadas[, c(1:5)]

test_that("Too few columns", {
  expect_error(rob_summary(test_sum, "QUADAS-2", weighted = TRUE))
  expect_error(rob_traffic_light(test_tf, "QUADAS-2"))
})

test_that("Error on saving with wrong file ext",{
  expect_error(rob_save(rob_fig,"test.pgg"))
})

# Need to add specific test for ROB1

data_header <- data_rob2
data_header[1,] <- as.list(names(data_header))

test_that("Data contains headers", {
  expect_error(rob_summary(data_header, "ROB2"))
  expect_error(rob_traffic_light(data_header, "ROB2"))
})

#-#-#-#

res <- c()

test_that("Check class of results object ", {
  expect_error(rob_append_weights(data_rob2, res))
  expect_error(rob_append_to_forest(res, data_rob2))
})

