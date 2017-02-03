makeCacheMatrix <- function(x = matrix()) {
    inv <- NULL
    # Similar to setting class level methods
    # or private inner methods in other 
    # languages
    set <- function(y) {
        x <<- y
        # Delete the old matrix
        inv <<- NULL
    }
    get <- function() x
    setInverse <- function(inverse) inv <<- inverse
    getInverse <- function() inv
    # Expose these methods via the list
    # containing the named methods 
    list(
        set = set, 
        get = get,
        setInverse = setInverse,
        getInverse = getInverse
    )
}

cacheSolve <- function(x, ...) {
    # Retrieve/Compute the matrix  
    inv <- x$getInverse()
    if(!is.null(inv)) {
        message("getting cached matrix data")
        return(inv)
    }
    data <- x$get()
    inv <- solve(data, ...)
    x$setInverse(inv)
    inv
}
