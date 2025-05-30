# Converted R script from RMarkdown
# Author: Timm Rogenmoser
# Description: Territorial study with regression, PCA, and clustering

# Setup
knitr::opts_chunk$set(echo = TRUE)

# Libraries
library(ggplot2)
library(nnet)
library(FactoMineR)
library(factoextra)

# Set working directory
path = getwd()
setwd(path)

# Load data for regression
d <- read.csv(file="../donnees/Etappe 1/donnees_wynental_tp2.csv", sep="\t")

# View dependent variable
table(d$typologie_ofs_court)

# Split data
idx <- sample(nrow(d), size=0.9*nrow(d))
dtrain <- d[idx,]
dtest <- d[-idx,]

# Multinomial logistic regression
regmlogit <- multinom(TYPE ~ SAU + EPT1 + SURFHAB + RESSEC, data=dtrain)

# Summary
summary(regmlogit)

# Confusion tables
table(predict(regmlogit, newdata=dtrain), dtrain$TYPE)
table(predict(regmlogit, newdata=dtest), dtest$TYPE)

# Accuracy
accuracy_train <- sum(predict(regmlogit, newdata=dtrain) == dtrain$TYPE) / nrow(dtrain)
accuracy_test <- sum(predict(regmlogit, newdata=dtest) == dtest$TYPE) / nrow(dtest)

accuracy_train
accuracy_test

# Bootstrapped accuracy
accuracy_train_d <- c()
accuracy_test_d <- c()

for (i in 1:100) {
 idx <- sample(nrow(d), size=0.9*nrow(d))
 dtrain <- d[idx,]
 dtest <- d[-idx,]
 
 regmlogit <- multinom(TYPE ~ SAU + EPT1 + SURFHAB, data=dtrain)
 
 accuracy_train <- sum(predict(regmlogit, newdata=dtrain) == dtrain$TYPE) / nrow(dtrain)
 accuracy_test <- sum(predict(regmlogit, newdata=dtest) == dtest$TYPE) / nrow(dtest)
 
 accuracy_train_d <- c(accuracy_train_d, accuracy_train)
 accuracy_test_d <- c(accuracy_test_d, accuracy_test)
}

# Evaluation
mean(accuracy_train_d)
mean(accuracy_test_d)

var(accuracy_train_d)
var(accuracy_test_d)

# Final model
donnees_regmlogit <- multinom(TYPE ~ SAU + EPT1 + SURFHAB, data=d)

# Export predictions
vector_prediction <- predict(regmlogit, newdata = d)
write.table(vector_prediction, "colonne_prediction.csv", sep = ";", col.names = "Prediction")

# PCA Analysis
d2 <- read.csv(file="../donnees/Etappe 2/acp_donnees_5.csv", sep="\t")
head(d2, 3)
ncol(d2)

d2_acp <- d2[,2:6]
head(d2_acp, 3)

# Correlation matrix
options(repr.matrix.max.rows=600, repr.matrix.max.cols=200)
cor(d2_acp)

cor_mat <- cor(d2_acp)
cor_mat[cor_mat == 1.0] <- 0
apply(cor_mat, 1, range)

# Run PCA
acp <- PCA(d2_acp, scale.unit=TRUE, ncp=5, graph=TRUE)
get_eig(acp)
get_eig(acp)[1:5,]

plot(acp$eig[1:5,2], type="o", xlab="Composante", ylab="% variance expliquée")
fviz_screeplot(acp, addlabels = TRUE, ylim = c(0, 50))

# PCA scores
plot.PCA(acp, axes=c(1,2), title="Scores factoriels", label="none", col.ind="blue")
fviz_pca_ind(acp, col.ind="cos2", gradient.cols=c("#E7B800", "#FC4E07"), geom="point")
acp$ind$coord
write.csv(acp$ind$coord, file="scores-factoriels2.csv")

# Communalities
plot.PCA(acp, axes=c(1,2), choix="var", title="Communalités")
fviz_pca_var(acp, col.var="contrib", gradient.cols=c("#E7B800", "#FC4E07"), repel=TRUE, title="Communalités", axes=c(1,2))
acp$var$cor

# Contribution plots
fviz_contrib(acp, choice="var", axes=1, top=20, title="Contribution dim 1")
fviz_contrib(acp, choice="var", axes=2, top=20, title="Contribution dim 2")
fviz_contrib(acp, choice="var", axes=3, top=20, title="Contribution dim 3")
fviz_contrib(acp, choice="var", axes=4, top=20, title="Contribution dim 4")
fviz_contrib(acp, choice="var", axes=5, top=20, title="Contribution dim 5")

# Biplot
fviz_pca_biplot(acp, geom.ind="point", geom.var=c("point", "text"), addEllipses=TRUE)

# Clustering (CAH)
d_sel <- d2[, 2:12]
dist <- dist(d_sel, method="euclidean")
clus_cah <- hclust(dist(d_sel), method="ward.D2")
plot(clus_cah, hang=-0.1, ylab="Distance", xlab="Communes", main="Dendogramme des clusters")

cah_partitions <- cutree(clus_cah, 4)
cah_partitions
write.csv(cah_partitions, file="clustering.csv")

# Cluster boxplots
cl_1 <- d_sel[c(1,3,9,11,14,16,20),]
cl_2 <- d_sel[c(2,7,8,12,13,15,22,24),]
cl_3 <- d_sel[c(4,5,6,10,17,18,19,21,23),]
cl_4 <- d_sel[c(25),]

# Visualizations
par(mfrow=c(1,4))
boxplot(cl_1$SURFIND, ylim=c(0,0.04), xlab="Cluster 1", ylab="[%]SURFIND")
boxplot(cl_2$SURFIND, ylim=c(0,0.04), xlab="Cluster 2", ylab="[%]SURFIND")
boxplot(cl_3$SURFIND, ylim=c(0,0.04), xlab="Cluster 3", ylab="[%]SURFIND")
boxplot(cl_4$SURFIND, ylim=c(0,0.04), xlab="Cluster 4", ylab="[%]SURFIND")
# Repeat for other variables as in original
