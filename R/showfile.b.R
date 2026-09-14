
showFileClass <- if (requireNamespace('jmvcore', quietly=TRUE)) R6::R6Class(
    "showFileClass",
    inherit = showFileBase,
    private = list(
        .run = function() {

            files <- c(list(self$options$file), self$options$files)
            files <- Filter(Negate(is.null), files)

            if (length(files) == 0) {
                self$results$content$setContent('(no file selected)')
                return()
            }

            chunks <- character()
            for (file in files) {
                text <- paste(readLines(file$path, warn=FALSE), collapse='\n')
                header <- paste0('==> ', file$filename, ' <==')
                chunks <- c(chunks, header, text)
            }

            self$results$content$setContent(paste(chunks, collapse='\n\n'))
        })
)
