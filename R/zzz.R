#' @import BiocFileCache
.onLoad <- function(libname, pkgname){
  ns <- asNamespace(pkgname)
  path <- system.file("extdata", package=pkgname, lib.loc=libname)
  metaData <- read.csv(paste0(path, "/metadata.csv"))
  url <- metaData$SourceUrl
  files <- bfcrpath(BiocFileCache(), url)
  for(i in seq_len(length(files))){
    # objname <- sub(".sqlite$","",basename(files[i]))
    objname <- metaData$Title[i]
    jasparDb <- new("JASPAR2022", db=files[i])
    assign(objname, jasparDb, envir=ns)
    namespaceExport(ns, objname)
  }
}
