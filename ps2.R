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
    # Retrieve the matrix  
    inv <- x$getInverse()
    # Check to see if the inverse
    # has already been computed
    if(!is.null(inv)) {
        # If not null, get the cached
        # matrix
        message("getting cached matrix data")
        return(inv)
    }
    data <- x$get()
    # 
    inv <- solve(data, ...)
    x$setInverse(inv)
    inv
}
