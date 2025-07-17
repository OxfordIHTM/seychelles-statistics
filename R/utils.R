#' 
#' Collect all targets and lists of targets in the environment
#' 
#' 
all_targets <- function(env = parent.env(environment()), 
                        type = "tar_target", 
                        add_list_names = TRUE) {
  
  ## Function to determine if an object is a type (a target), 
  ## or a list on only that type
  rfn <- function(obj) 
    inherits(obj, type) || (is.list(obj) && all(vapply(obj, rfn, logical(1))))
  
  ## Get the names of everything in the environment 
  ## (e.g. sourced in the _targets.R file)
  objs <- ls(env)
  
  out <- list()
  for (o in objs) {
    obj <- get(o, envir = env)      ## Get each top-level object in turn
    if (rfn(obj)) {                 ## For targets and lists of targets
      out[[length(out) + 1]] <- obj ## Add them to the output
      
      ## If the object is a list of targets, add a vector of the target names 
      ## to the environment So that one can call `tar_make(list_name)` to make 
      ## all the targets in that list
      if (add_list_names && is.list(obj)) {
        target_names <- vapply(obj, \(x) x$settings$name, character(1))
        assign(o, target_names, envir = env)
      }
    }
  }
  return(out)
}


#'
#' Get GitHub repository ID
#' 
#' @param repo Short remote git repository name for current project.
#' 
#' @returns An integer value for the GitHub repository ID.
#' 
#' @examples
#' if (FALSE) get_gihtub_repository_id(repo = "katilingban/pakete")
#' 
#' @keywords internal
#' 

get_github_repository_id <- function(repo) {
  ## Get repository ID ----
  file.path("https://api.github.com/repos", repo) |>
    jsonlite::fromJSON() |>
    (\(x) x$id)()
}


  ## Set CodeFactor defaults ----
  # badge <- paste0("https://zenodo.org/badge/", repo_id, ".svg")
  # link <- paste0("https://zenodo.org/badge/latestdoi/", repo_id)

  ## Create badge text ----
  # badge_text <- paste0("[![DOI](", badge, ")](", link, ")")