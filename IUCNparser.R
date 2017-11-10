path = "C:/Users/Nathan/Desktop/IUCNparser"
dataDir = "Pteropodidae"

setwd(path)

files = list.files(path=paste(path, "/", dataDir, sep=""))

parsePage <- function(data, df) {
  temp <- data.frame(ROW=rep(NA, length(data)))

  for (i in 1:length(data)) {
    temp$ROW[i] <- data[i]
  }

  data <- temp

  i <- 1

  while (i < nrow(data) + 1) {
    spStr <- strsplit(data[i, 1], "Map_thumbnail_small ")[[1]][2]
    spStr <- strsplit(spStr, "[()]")

    sp <- strsplit(spStr[[1]][1], " ")
    sp <- paste(sp[[1]][1], sp[[1]][2], sep=" ")

    cn <- spStr[[1]][2]

    i <- i + 1

    status <- strsplit(data[i, 1], " ")[[1]][2]

    if (status == "Extinct" && is.na(strsplit(data[i, 1], " ")[[1]][3]) == F) {
      sib <- strsplit(data[i, 1], " ")[[1]][3]
      if (sib == "in") {
        status = paste(status, sib, strsplit(data[i, 1], " ")[[1]][4], strsplit(data[i, 1], " ")[[1]][5], sep=" ")
      }
    } else if (status == "Critically" && is.na(strsplit(data[i, 1], " ")[[1]][3]) == F) {
      status = paste(status, strsplit(data[i, 1], " ")[[1]][3], sep=" ")
    } else if (status == "Near" && is.na(strsplit(data[i, 1], " ")[[1]][3]) == F) {
      status = paste(status, strsplit(data[i, 1], " ")[[1]][3], sep=" ")
    } else if (status == "Least" && is.na(strsplit(data[i, 1], " ")[[1]][3]) == F) {
      status = paste(status, strsplit(data[i, 1], " ")[[1]][3], sep=" ")
    } else if (status == "Data" && is.na(strsplit(data[i, 1], " ")[[1]][3]) == F) {
      status = paste(status, strsplit(data[i, 1], " ")[[1]][3], sep=" ")
    } else if (status == "Not" && is.na(strsplit(data[i, 1], " ")[[1]][3]) == F) {
      status = paste(status, strsplit(data[i, 1], " ")[[1]][3], sep=" ")
    }

    if (status == "Extinct" || status == "Extinct in the Wild") {
      trend <- NA
    } else {
      i <- i + 1

      trend <- strsplit(data[i, 1], " ")[[1]][3]
    }

    i <- i + 1

    df <- rbind(df, data.frame(sp, cn, status, trend, stringsAsFactors=F))
  }

  return(df)
}

df <- data.frame(stringsAsFactors=F)

for (i in files) {
  data <- readLines(paste(dataDir, "/", i, sep=""))
  df <- parsePage(data, df)
}

colnames(df) <- c("SPECIES", "NAME", "STATUS", "POP_TREND")

write.csv(df, paste(dataDir, "_results.csv", sep=""))

stats <- c("Extinct", "Extinct in the Wild", "Critically Endangered", "Endangered",
           "Vulnerable", "Near Threatened", "Least Concern", "Data Deficient",
           "Not Evaluated")

df_s <- data.frame(STATUS=stats, COUNT=rep(0, length(stats)), stringsAsFactors=F)

for (i in 1:nrow(df)) {
  row <- match(df$STATUS[i], df_s$STATUS)
  df_s[row, 2] <- df_s[row, 2] + 1
}

write.csv(df_s, paste(dataDir, "_breakdown_status.csv", sep=""))

trends <- c("decreasing", "unknown", "stable", "increasing", NA)

df_t <- data.frame(POP_TREND=trends, COUNT=rep(0, length(trends)), stringsAsFactors=F)

for (i in 1:nrow(df)) {
  row <- match(df$POP_TREND[i], df_t$POP_TREND)
  df_t[row, 2] <- df_t[row, 2] + 1
}

write.csv(df_t, paste(dataDir, "_breakdown_popTrends.csv", sep=""))
