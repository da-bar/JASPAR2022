.onLoad <- function(libname, pkgname){
  ns <- asNamespace(pkgname)
  path <- system.file("extdata", package=pkgname, lib.loc=libname)
  metaData <- read.csv(paste0(path, "/metadata.csv"))
  download.file(metaData$SourceUrl, destfile =
                  paste0(path, "/", basename(metaData$SourceUrl)))
  files <- list.files(path, pattern="\\.sqlite$", full.names=TRUE)
  for(i in seq_len(length(files))){
    objname <- sub(".sqlite$","",basename(files[i]))
    jasparDb <- new("JASPAR2022", db=files[i])
    assign(objname, jasparDb, envir=ns)
    namespaceExport(ns, objname)
  }
}
