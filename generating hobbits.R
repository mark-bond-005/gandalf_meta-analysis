# Hobbit names were generated using the hobbit name generator online, http://www.chriswetherell.com/hobbit/
# Elven names were generatd in much the same way, http://www.chriswetherell.com/elf/
# Dwarven names were generated using the software Dwarf Fortress, http://www.bay12games.com/dwarves/
authorNames <- c("Chubb", "Bunce", "Goldworthy",
                    "Bleeker-Baggins", "Brandybuck", "Bramble",
                    "Brockhouse",
                 "Lalturmorul", "Nethonul", "Bisekfath",
                     "Vushcog", "Ienthfotthor", "Gusilidek",
                     "Imushokun", "Oltarcatten", "Kezattun",
                     "Momuztobul",
                 "Melwas?l", "Felagund", "N?pold?"
                 )
authorRace <- factor(c(rep("Hobbit", 7), rep("Dwarf", 10), rep("Elf", 3)))

# Fo. A. stands for "Fourth Age", which is after the War of the Rings.
pubYear <- paste("Fo. A.", round(runif(20, min = 1, max=50), digits = 0))

# Psychology studies would be lucky to have these sample sizes.
totN <- round(runif(n = 20, min = 30, max = 300), digits = 0)

# Random assignment to treatment or control group.
nTrt <- rbinom(20, totN, 0.5)
nCtr <- totN - nTrt

# The variance of elvish aggression is low
# THe variance of dwarvish aggression reduces when they have shiny things
# The variance of hobbits' aggression increases and gets more volatile when they are around rings.
sdTrt <- round(sqrt(c(rchisq(7, nTrt[1:7]-1, 5), rchisq(10, nTrt[8:17]-1, 5), rchisq(3, nTrt[18:20]-1, 9))), digits = 3)
sdCtr <- round(sqrt(c(rchisq(7, nTrt[1:7]-1, 10), rchisq(10, nTrt[8:17]-1, 9), rchisq(3, nTrt[18:20]-1, 9))), digits = 3)

# Remember that higher numbers indicate more aggression.
# Rings stress hobbits out, calm dwarves down, and do nothing to elves.
# In the absence of rings, hobbits are pretty calm and dwarves are angry. Elves always keep their cool
# We are simulating a sampling distribution, so the standard deviation is sigma/sqrt(n)
mTrt <- round(c(rnorm(7, mean = 2, sd=sdTrt[1:7]/sqrt(nTrt[1:7])), rnorm(10, mean = -1, sd=sdTrt[8:17]/sqrt(nTrt[8:17])), rnorm(3, -2, sd=sdTrt[18:20]/sqrt(nTrt[18:20]))), digits = 3)
mCtr <- round(c(rnorm(7, mean = -1, sd=sdCtr[1:7]/sqrt(nCtr[1:7])), rnorm(10, mean = 1, sd=sdCtr[8:17]/sqrt(nCtr[8:17])), rnorm(3, -2, sd=sdCtr[18:20]/sqrt(nCtr[18:20]))), digits = 3)

lotrDat <- as.data.frame(list(authorNames, authorRace, pubYear, nTrt, nCtr,mTrt, mCtr, sdTrt, sdCtr))
names(lotrDat) <- c("Author_name", "Author_race", "Pub_year", "N_treat", "N_control", "Mean_treat", "Mean_control", "SD_treat", "SD_control")
lotrDat$Pub_year_ZScore <- scale(as.numeric(substr(lotrDat$Pub_year, 7,9)))
#save.image("~/classes fall 15/Consulting class/generating hobbits.RData")
