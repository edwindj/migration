data.age <- read.csv2("data/population_age_mun2.csv")

data.age2 <- within(data.age,{
  Leeftijd <- as.integer(sub(" ja.*","", data.age2$Leeftijd))
  ageGroup <- cut(Leeftijd, breaks=seq(0, 100, by=5), right=FALSE)
  ageGroupN <- as.integer(ageGroup)
  Mannen <- as.integer(as.character(Mannen))
  Vrouwen <- as.integer(as.character(Vrouwen))
  code <- factor(sprintf("GM%04d", data.age$code))
})

write.csv(data.age2, "json/age_sex_gem_2010.csv", row.names=FALSE, na="")
