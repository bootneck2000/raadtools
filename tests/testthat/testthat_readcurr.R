
require(testthat)
require(raadtools)
require(ncdf)
test_that("current data is returned as a raster object", {
           expect_that(readcurr("2000-01-01"), is_a("RasterBrick"))
      })

test_that("multiple dates are supported only with magonly/dironly, and if given the length is 2", {
           expect_that(readcurr(c("2000-01-01", "2003-01-10")), gives_warning())
           expect_that(readcurr(c("2000-01-01", "2003-01-10"), dironly = TRUE), is_a("RasterBrick"))
           expect_that(nlayers(readcurr(c("2000-01-01", "2003-01-10"), magonly = TRUE)), equals(2))
                 })

test_that("multi layers returned with magonly or dironly", {
    expect_that(nlayers(readcurr(c("2000-01-01", "2003-01-10"), magonly = TRUE)), equals(2))
    expect_that(nlayers(readcurr(c("2000-01-01", "2003-01-10"), dironly = TRUE)), equals(2))
    expect_that(readcurr(c("2000-01-01"), magonly = TRUE, dironly = TRUE), throws_error())
    expect_that(readcurr(c("2000-01-01"), vonly = TRUE, dironly = TRUE), throws_error())
})



test_that("dates not available within 4 days give error", {
     expect_that(readcurr("1999-11-19"), throws_error("no data file within"))
})


test_that("input crop extent works for a time series", {

  ext <- extent(0, 20037508, -13500000, -5400000)

  dts <- seq(as.Date("2001-01-03"), by = "1 month", length = 5)
  curr <- readcurr(dts, xylim = ext, magonly = TRUE)
  expect_that(curr, is_a("RasterBrick"))
  expect_that(dim(curr), equals(c(219L, 540L, 5L)))

})

