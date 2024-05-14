#' @name AB_sym
#' @aliases evo
#' @aliases eco
#' @title ODE system for algal-bacteria community dynamics
#'
#' @description AB_sym_IER is a function with ordinary differential equations for the rotifer-algal predator-prey dynamics under the model described in Hermann & Becks (2022). evo is a function with ODEs where the algal population consits of two different clonal lineages, which can change in frequency. eco is a function with ODEs where the algal population consits of one clonal lienage the summed up defense and growth rate of the starting frequency of each clonal lineage from evo x their respective traits 
#'
#'@param t A vector of time steps for which the differential equations will be evaluated across
#' @param x A vector of starting values for N, C1, C2, B, S.
#' @param params A vector of values for the model parameters:
#' \itemize{
#' \item{Ni}{Limiting N concentration}
#' \item{V}{Chemostat volume}
#' \item{D}{Chemostat dilution rate}
#' \item{Kb}{Rotifer consumption half-saturation constant}
#' \item{Bc}{Algae maximum recruitment rate}
#' \item{Bb}Rotifer maximum recruitment rate}
#' \item{P}{Algae minimum food value}
#' \item{Xc}{Algae conversion efficiency}
#' \item{Xb}{Rotifer conversion efficiency}
#' \item{G}{Rotifer maximum clearance rate}
#' \item{L}{Rotifer senescence rate}
#' \item{M}{Rotifer mortality rate}
#' \item{P1}Clone 1 palatability (low defense)}
#' \item{P2}Clone 2 palatability (high defense)}
#' \item{Kc1}{Clone 1 minimum half-saturation constant (high growth)}
#' \item{Kc2}{Clone 2 minimum half-saturation constant (low growth)}
#' 
#' @return The values of the derivatives in the ODE system at time t.
#' 
#' 
evo <- function(t,x,params){
  ## first extract the state variables
  N <- x[1]
  C1 <- x[2]
  C2 <- x[3]
  B <- x[4]
  S <- x[5]
  ## now extract the parameters
  ## non-biological parameters
  Ni <- params["Ni"]
  V <- params["V"]
  D <- params["D"]
  ## biological parameters:
  Kb <- params["Kb"]
  Bc <- params["Bc"]
  Bb <- params["Bb"]
  P <- params["P"]
  Xc <- params["Xc"]
  Xb <- params["Xb"]
  G <- params["G"]
  L <- params["L"]
  M <- params["M"]
  ## trait parameters of the clones
  P1 <- params["P1"]
  P2 <- params["P2"]
  Kc1 <- params["Kc1"]
  Kc2 <- params["Kc2"]
  Bc1 <- params["Bc1"]
  Bc2 <- params["Bc2"]
                                                            
  ## now code the model equations
  dN = D*(Ni - N) - P*C1*N/(Kc1 + N) -  P*C2*N/(Kc2 + N)                             # Nitrogen dynamic
  
  dC1 = C1*(Xc*P*N/(Kc1 + N) - P1*G*(B + S)/(Kb + max(P1*C1 + P2*C2)) - D)        # Algae 1 dynamic
  
  dC2 = C2*(Xc*P*N/(Kc2 + N) - P2*G*(B + S)/(Kb + max(P1*C1 + P2*C2)) - D)        # Algae 2 dynamic
  
  dB = B*(Xb*G*(P1*C1 + P2*C2)/(Kb + max(P1*C1 + P2*C2)) - (D + M + L))           # Breeding rotifers dynamic
  
  dS = L*B - (D + M)*S                                                               # Senescent rotifers dynamic
  
  return(list(c(dN,dC1,dC2,dB,dS)))
}

#THis is the ode function from the model above
AB_sym <- function(t, x, params){
  out <- as.data.frame(deSolve::ode(y=x,times=t,func=evo,parms=params,method="lsoda"))
}