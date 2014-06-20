makeCacheMatrix <- function(x=matrix,...){                        #creates list of functions that is our Matrix-like object
	invrs <- NULL                                             #initiates invrs 
	set <- function(y){    					  #Tells list of functions which matrix to operate on
		x <<- y						  #Caches this information
		invrs <<-NULL
	}
	get <- function() x					#Returns cached Matrix
	setinvrs <- function(inv) invrs<<-inv			#Caches invrs as given value(N.B. doesn't calculate anything)
	getinvrs <- function() invrs				#Returns cached invrs
	list(set=set,get=get,setinvrs=setinvrs,getinvrs=getinvrs)#Creates list allowing you to call these functions
}
cacheSolve <- function(x,...){					#Actually solves for an inverse
	invrs = x$getinvrs()					#gets cached data
	if(!is.null(invrs)){					#checks if a value is present, if yes, returns value
		message("getting cached data")
		return(invrs)
	}
	data <- x$get()						#Gets and solves for the inverse of matrix assigned to getCacheMatrix
	invrs <- solve(data,...)
	x$setinvrs(invrs)					#Sets the inverse
	invrs							#Returns it		
}
