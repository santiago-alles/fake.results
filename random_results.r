#### R Script: Random Election Results
#### by Santiago Alles, PhD
#### Universidad del Rosario

#### Updated to: 07/29/2017
#### version 1.0
#### Available at: http://www.santiago-alles.net/


results.FUN <- function( parties = c("red", "blue", "brown", "yellow", "black") , 
                         num.districts = round(runif(1, 10,35) ) ,
                         chambers = c("lower", "upper") ,
                         years = seq(round(runif(1, 1945, 1970 )), round(runif(1, 1980, 2016)), 
                                     round(runif(1, 2, 6))) ){
  
  #### Checking Packages
  if("doBy" %in% installed.packages() == F){
    print("Installing required packages", quote = F)
    install.packages("doBy", verbose = F, quiet = T)
    
  }
  
  if("doBy" %in% installed.packages() ){
    require("doBy")
    
  } else {
    print("Error: A required package is missing and could not be installed", quote = F)
    
  }
  
  #### Building Random Data
  for( i in 1:length(years) ){
    for( j in 1:length(chambers) ){
      for( k in 1:num.districts ){
        
        ## Election: Year + Chamber + District
        data.frame( Year = years[i], Chamber = chambers[j], 
                    District = paste( "district", paste(rep(0,nchar(num.districts)-nchar(seq(1,num.districts)[k])), 
                                                        seq(1,num.districts)[k], sep=""), 
                                      sep="-" ) ) -> dist_election
 
        ## District results
        round(rgamma( 1, shape = 1, scale = 1)) -> n_parties
        ifelse( length(parties) - n_parties < 2, 2, length(parties) - n_parties ) -> n_parties
        
        data.frame( dist_election, Party = sample( parties, size = n_parties ), Votes = NA ) -> dist_election
  
        for( z in 1:n_parties){
          if( z == 1){
            
            rnorm(1, .4, .1) -> dist_election$Votes[sample(n_parties, 1)]
            
          } else {
            if( z == n_parties){
              
              1-sum(dist_election$Votes, na.rm = T) -> 
                dist_election$Votes[as.numeric(sample(row.names(dist_election[is.na(dist_election$Votes),]), 1))]
              
            } else {
              runif(1, 0, 1-sum(dist_election$Votes, na.rm = T)) -> 
                dist_election$Votes[as.numeric(sample(row.names(dist_election[is.na(dist_election$Votes),]), 1))]
              
            }            
          }

        }
        
        round(dist_election$Votes * abs(rnorm(1, 150000, sd = 15000))) -> dist_election$Votes
        
        ## Building Dataset
        if("elections" %in% ls()) elections <- rbind(dist_election, elections) else elections <- dist_election

      }
      
    }

      
    
  }
  
  data.frame( orderBy( ~ Year - Chamber - District + Party, data = elections ),
              row.names = NULL) -> elections
  
  return( elections )
 
}
