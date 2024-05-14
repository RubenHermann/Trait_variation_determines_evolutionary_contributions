#' @name Geber_method
#' @title Calculating the relative impact of evolution and ecology, by applying the geber method
#'
#' @description The method is from the publication from Hairston et al 2011, where they apply a two-way ANOVA on the data in order the determine the relative contribution of evolution and ecology on a resposne variable
#'
#'@param all_out A data frame with the results from the model with the different
#' \itemize{
#' \item{time}{Time step in the model}
#' \item{N}{Nitrogen concentration (limiting resource)}
#' \item{C1}{Density of the undefeded clone in 10^6 cells/ml}
#' \item{C2}{Density of thendefeded clone in 10^6 cells/ml}
#' \item{B}{Density of reproducing rotifers per ml}
#' \item{S}{Density in senescent (non-reproducing) rotifers per ml}
#' \item{run}{ID of the simulation}
#' \item{C_all}{Total algal density}
#' \item{freq_def}{Frequency of the defended clone}
#' \item{start_freq}{Starting frequency of the defended clone}
#' }
#' @param all_col A collection of the traits from both algal clones in the model with the simulation parameters
#' \itemize{
#' \item{Kc1}{Half-saturation constant of the undefended clone}
#' \item{Kc2}{Half-saturation constant of the defended clone}
#' \item{P1}{Palatability of the undefeded clone}
#' \item{P2}{Palatability of the defended clone}
#' \item{run}{ID of the simulation}
#' }
#' 
#' @return The relative influence of evolution and ecology at time point t
#' 


Geber_method <- function(dat,t){
 
  ## Model fit between property of the system ~ eco*evo
  #property of the system is the X response value rotifer fitness (growth rate); eco = algal density; evo = frequency of defended clone
  #than I am taking the coefficients (both standard errors for eco*evo and intercept) from the fit
  fit<-lm(dat$B_growth~dat$var_x)
  sto <- c(coef(summary(fit))[1,1],coef(summary(fit))[2,1])
  ## Calculating the contribution of evolution and ecology
  #For that I am using again the eco and evo values + the coefficients from the fit
  for(j in 1:length(t)){
    a=sto[1]+sto[2]*dat$freq_udef[j]*dat$C_all[j]
    
    b=sto[1]+sto[2]*dat$freq_udef[j]*dat$C_all[j+1]
      
    c=sto[1]+sto[2]*dat$freq_udef[j+1]*dat$C_all[j]
      
    d=sto[1]+sto[2]*dat$freq_udef[j+1]*dat$C_all[j+1]
      
    evo=((c-a)+(d-b))/2
    eco=((b-a)+(d-c))/2
    dat$evo[j] <- evo
    dat$eco[j] <- eco
    dat$evo_eco[j] <- evo/eco
    dat$ln_evo_eco <- log(abs(dat$evo_eco))
    }
  return(dat)
}    