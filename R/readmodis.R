#' @importFrom raster setExtent mask
readmsst <- function(date, returnfiles = FALSE, latest  = FALSE, rescale = TRUE) {
  
  
  files <- list.files("/rdsi/PRIVATE/data/oceandata.sci.gsfc.nasa.gov/MODIST/Mapped/Monthly/9km/SST", 
                      pattern = "SST_9$", full.names = TRUE)
  files <- data.frame(fullname = files, date = as.POSIXct(strptime(basename(files), "T%Y%j")), 
                      stringsAsFactors = FALSE)
  if (returnfiles) return(files)
  if (latest) date <- max(files$date)
  if (missing(date)) date <- min(files$date)
  date <- as.POSIXct(date, tz = "UTC")
  
  files <- .processFiles( date, files, "monthly")
  files$sds <- sprintf('HDF4_SDS:UNKNOWN:%s:0', files$fullname)
  
  x <-  setExtent(brick(stack(files$sds)),  extent(-180, 180, -90, 90))
  projection(x) <- "+proj=longlat +ellps=WGS84"
  if (rescale) x * 0.000717184972 -2 else x
  
}
