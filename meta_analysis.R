load("~/classes fall 15/Consulting class/hobbits.RData")
library("metafor"); library("ggplot2")

# Compute a standardized effect size, the standardized mean difference, for each study
lotrDat <- escalc(measure = "SMD", 
                  m1i = Mean_treat, m2i = Mean_control,
                  sd1i = SD_treat, sd2i = SD_control,
                  n1i = N_treat, n2i = N_control,
                  data = lotrDat, append = T)
lotrDat[ , c("Author_race", "yi", "vi")]

# Fit a random-effects model to test if there is hetereogeneity in the true effect sizes
nullRingModel <- rma.uni(yi = yi, vi = vi, 
                        data = lotrDat)
nullRingModel

# Fit a mixed-effects model to test if author race or publication year significantly predicts anything.
twoRingModel <- rma.uni(yi = yi, vi = vi,
                        mods = ~ Author_race + Pub_year_ZScore,
                        data = lotrDat)
twoRingModel

