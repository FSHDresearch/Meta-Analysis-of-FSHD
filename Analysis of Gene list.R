load("ResultsGeneSel_EGAD00001008337.RData")
load("ResultsGeneSel_GSE10760.RData")
load("ResultsGeneSel_GSE15090.RData")
load("ResultsGeneSel_GSE26061.RData")
load("ResultsGeneSel_GSE26145.RData")
load("ResultsGeneSel_GSE26852.RData")
load("ResultsGeneSel_GSE36398.RData")
load("ResultsGeneSel_GSE56787biopsy.RData")
load("ResultsGeneSel_GSE56787celllines.RData")
load("ResultsGeneSel_GSE115650.RData")
load("ResultsGeneSel_GSE123468_Fam12.RData")
load("ResultsGeneSel_GSE123468_Fam16.RData")
load("ResultsGeneSel_GSE138768.RData")

names(res.GeneSel.EGAD00001008337) <- paste0("GeneSel.EGAD00001008337.", names(res.GeneSel.EGAD00001008337))
names(res.GeneSel.GSE10760) <- paste0("GeneSel.GSE10760.", names(res.GeneSel.GSE10760))
names(res.GeneSel.GSE15090) <- paste0("GeneSel.GSE15090", names(res.GeneSel.GSE15090))
names(res.GeneSel.GSE26061) <- paste0("GeneSel.GSE26061", names(res.GeneSel.GSE26061))
names(res.GeneSel.GSE26145) <- paste0("GeneSel.GSE26145", names(res.GeneSel.GSE26145))
names(res.GeneSel.GSE26852_stir) <- paste0("GeneSel.GSE26852.", names(res.GeneSel.GSE26852_stir))
names(res.GeneSel.GSE36398) <- paste0("GeneSel.GSE36398", names(res.GeneSel.GSE36398))
names(res.GeneSel.GSE56787) <- paste0("GeneSel.GSE56787", names(res.GeneSel.GSE56787))
names(res.GeneSel.GSE56787celllines) <- paste0("GeneSel.GSE56787celllines", names(res.GeneSel.GSE56787celllines))
names(res.GeneSel.GSE115650) <- paste0("GeneSel.GSE115650", names(res.GeneSel.GSE115650))
names(res.GeneSel.GSE123468_12) <- paste0("GeneSel.GSE123468_12.", names(res.GeneSel.GSE123468_12))
names(res.GeneSel.GSE123468_16) <- paste0("GeneSel.GSE123468_16.", names(res.GeneSel.GSE123468_16))
names(res.GeneSel.GSE138768) <- paste0("GeneSel.GSE138768.", names(res.GeneSel.GSE138768))


## adj. p value < 0.05
res.GeneSel.EGAD00001008337.sel <- res.GeneSel.EGAD00001008337[res.GeneSel.EGAD00001008337$GeneSel.EGAD00001008337.adj.P.Val < 0.05,]
res.GeneSel.GSE10760.sel <- res.GeneSel.GSE10760[res.GeneSel.GSE10760$GeneSel.GSE10760.adj.p.value < 0.05,]
res.GeneSel.GSE15090.sel <- res.GeneSel.GSE15090[res.GeneSel.GSE15090$GeneSel.GSE15090adj.p.value < 0.05,]
res.GeneSel.GSE26061.sel <- res.GeneSel.GSE26061[res.GeneSel.GSE26061$`GeneSel.GSE26061group: adj.P.Val` < 0.05,]
res.GeneSel.GSE26145.sel <- res.GeneSel.GSE26145[res.GeneSel.GSE26145$`GeneSel.GSE26145group: adj.P.Val` < 0.05,]
res.GeneSel.GSE26852.sel <- res.GeneSel.GSE26852_stir[res.GeneSel.GSE26852_stir$GeneSel.GSE26852.adj.p.value < 0.05,]
res.GeneSel.GSE36398.sel <- res.GeneSel.GSE36398[res.GeneSel.GSE36398$GeneSel.GSE36398adj.p.value < 0.05,]
res.GeneSel.GSE56787.sel <- res.GeneSel.GSE56787[res.GeneSel.GSE56787$GeneSel.GSE56787adj.P.Val < 0.05,]
res.GeneSel.GSE56787celllines.sel <- res.GeneSel.GSE56787celllines[res.GeneSel.GSE56787celllines$`GeneSel.GSE56787celllinesgroup: adj.P.Val` < 0.05,]
res.GeneSel.GSE115650.sel <- res.GeneSel.GSE115650[res.GeneSel.GSE115650$GeneSel.GSE115650adj.P.Val < 0.05,]
res.GeneSel.GSE123468_12.sel <- res.GeneSel.GSE123468_12[res.GeneSel.GSE123468_12$`GeneSel.GSE123468_12.group12: adj.P.Val` < 0.05,]
res.GeneSel.GSE123468_16.sel <- res.GeneSel.GSE123468_16[res.GeneSel.GSE123468_16$`GeneSel.GSE123468_16.group16: adj.P.Val` < 0.05,]
res.GeneSel.GSE138768.sel <- res.GeneSel.GSE138768[res.GeneSel.GSE138768$GeneSel.GSE138768.adj.P.Val < 0.05,]


dim(res.GeneSel.EGAD00001008337.sel)
dim(res.GeneSel.GSE10760.sel)
Daten.zs <- merge(res.GeneSel.EGAD00001008337.sel, res.GeneSel.GSE10760.sel, by.x = "GeneSel.EGAD00001008337.ENSEMBLE",
                  by.y = "GeneSel.GSE10760.ENSEMBL", all = TRUE)

dim(res.GeneSel.GSE15090.sel)
Daten.zs <- merge(Daten.zs, res.GeneSel.GSE15090.sel, by.x = "GeneSel.EGAD00001008337.ENSEMBLE",
                  by.y = "GeneSel.GSE15090ENSEMBL", all = TRUE)


dim(res.GeneSel.GSE26061.sel)
Daten.zs <- merge(Daten.zs,res.GeneSel.GSE26061.sel, by.x = "GeneSel.EGAD00001008337.ENSEMBLE",
                  by.y = "GeneSel.GSE26061ENSEMBL", all = TRUE)
dim(res.GeneSel.GSE26145.sel)
Daten.zs <- merge(Daten.zs,res.GeneSel.GSE26145.sel, by.x = "GeneSel.EGAD00001008337.ENSEMBLE",
                  by.y = "GeneSel.GSE26145ENSEMBL", all = TRUE)

dim(res.GeneSel.GSE26852.sel)
Daten.zs <- merge(Daten.zs,res.GeneSel.GSE26852.sel,  by.x = "GeneSel.EGAD00001008337.ENSEMBLE",
                  by.y = "GeneSel.GSE26852.ENSEMBL", all = TRUE)



dim(res.GeneSel.GSE36398.sel)
Daten.zs <- merge(Daten.zs,res.GeneSel.GSE36398.sel, by.x = "GeneSel.EGAD00001008337.ENSEMBLE",
                  by.y = "GeneSel.GSE36398ENSEMBL", all = TRUE)


dim(res.GeneSel.GSE56787.sel)
Daten.zs <- merge(Daten.zs,res.GeneSel.GSE56787.sel, by.x = "GeneSel.EGAD00001008337.ENSEMBLE",
                  by.y = "GeneSel.GSE56787ENSEMBLE", all = TRUE)

dim(res.GeneSel.GSE56787celllines.sel)
Daten.zs <- merge(Daten.zs,res.GeneSel.GSE56787celllines.sel, by.x = "GeneSel.EGAD00001008337.ENSEMBLE",
                  by.y = "GeneSel.GSE56787celllinesENSEMBLE", all = TRUE)


dim(res.GeneSel.GSE115650.sel)
Daten.zs <- merge(Daten.zs, res.GeneSel.GSE115650.sel, by.x = "GeneSel.EGAD00001008337.ENSEMBLE", 
                  by.y = "GeneSel.GSE115650ENSEMBLE", all = TRUE)

dim(res.GeneSel.GSE123468_12.sel)
Daten.zs <- merge(Daten.zs, res.GeneSel.GSE123468_12.sel, by.x = "GeneSel.EGAD00001008337.ENSEMBLE", 
                  by.y = "GeneSel.GSE123468_12.ENSEMBLE", all = TRUE)
dim(res.GeneSel.GSE123468_16.sel)
Daten.zs <- merge(Daten.zs, res.GeneSel.GSE123468_16.sel, by.x = "GeneSel.EGAD00001008337.ENSEMBLE", 
                  by.y = "GeneSel.GSE123468_16.ENSEMBLE", all = TRUE)
dim(res.GeneSel.GSE138768.sel)
Daten.zs <- merge(Daten.zs, res.GeneSel.GSE138768.sel, by.x = "GeneSel.EGAD00001008337.ENSEMBLE", 
                  by.y = "GeneSel.GSE138768.ENSEMBLE", all = TRUE)


Daten.zs$Nr.signif.res <- rowSums(Daten.zs[,c("GeneSel.EGAD00001008337.adj.P.Val", 
                                              "GeneSel.GSE10760.adj.p.value",
                                              "GeneSel.GSE15090adj.p.value",
                                              "GeneSel.GSE26061group: adj.P.Val",
                                              "GeneSel.GSE26145group: adj.P.Val",
                                              "GeneSel.GSE26852.adj.p.value",
                                              "GeneSel.GSE36398adj.p.value",
                                              "GeneSel.GSE56787adj.P.Val",
                                              "GeneSel.GSE56787celllinesgroup: adj.P.Val",
                                              "GeneSel.GSE115650adj.P.Val",
                                              "GeneSel.GSE123468_12.group12: adj.P.Val",
                                              "GeneSel.GSE123468_16.group16: adj.P.Val",
                                              "GeneSel.GSE138768.adj.P.Val")] < 0.05, na.rm = TRUE)


Daten.zs <- Daten.zs[order(Daten.zs$Nr.signif.res, decreasing = TRUE),]
head(Daten.zs, n = 20)

Daten.zs.sel <- Daten.zs[,c("GeneSel.EGAD00001008337.ENSEMBLE", "GeneSel.GSE26852.SYMBOL", "Nr.signif.res")]
Daten.zs.sel <- Daten.zs.sel[!duplicated(Daten.zs.sel),]

## Keine ENSEMBLE ID???
sum(is.na(Daten.zs.sel$GeneSel.EGAD00001008337.ENSEMBLE))
Daten.zs.sel[is.na(Daten.zs.sel$GeneSel.EGAD00001008337.ENSEMBLE),]

Daten.zs.sel <- Daten.zs.sel[!is.na(Daten.zs.sel$GeneSel.EGAD00001008337.ENSEMBLE),]
head(Daten.zs.sel, n = 20)

## aktuelle Annotation (hoffentlich stimmen die ENSEMBLE-IDs ...)
## insbesonder auch Auffüllen fehlender Gennamen
library(AnnotationHub)
ah <- AnnotationHub()
query(ah, "EnsDb")
ahDb <- query(ah, pattern = c("Homo sapiens", "EnsDb", 107))
ahEdb <- ahDb[[1]]
gns <- genes(ahEdb)
str(gns)
gnsIDs <- gns@elementMetadata@listData
Daten.zs.sel$gene_name <- ""
for(i in 1:nrow(Daten.zs.sel)){
  sel <- which(gnsIDs$gene_id == Daten.zs.sel$GeneSel.EGAD00001008337.ENSEMBLE[i])
  if(length(sel) == 0){
    print(gnsIDs$gene_name[sel])
    print(Daten.zs.sel$GeneSel.EGAD00001008337.ENSEMBLE[i])
  }
  if(length(sel) > 1){
    print(gnsIDs$gene_name[sel])
    print(Daten.zs.sel$GeneSel.EGAD00001008337.ENSEMBLE[i])
  }
    
  Daten.zs.sel$gene_name[i] <- gnsIDs$gene_name[sel[1]]
}

## nur noch ein paar wenige doppelte ENSEMBLE IDs
sort(table(Daten.zs.sel$GeneSel.EGAD00001008337.ENSEMBLE), decreasing = TRUE)[1:20]

## ENSEMBLE IDs mit 13 sig. Ergebnissen
Daten.zs.sel[Daten.zs.sel$Nr.signif.res >= 13,]

## ENSEMBLE IDs mit mind. 12 sig. Ergebnissen
Daten.zs.sel[Daten.zs.sel$Nr.signif.res >= 12,]

## ENSEMBLE IDs mit mind. 11 sig. Ergebnissen
Daten.zs.sel[Daten.zs.sel$Nr.signif.res >= 11,]

## ENSEMBLE IDs mit mind. 10 sig. Ergebnissen
Daten.zs.sel[Daten.zs.sel$Nr.signif.res >= 10,]

## ENSEMBLE IDs mit mind. 9 sig. Ergebnissen
Daten.zs.sel[Daten.zs.sel$Nr.signif.res >= 9,]

## ENSEMBLE IDs mit mind. 8 sig. Ergebnissen
Daten.zs.sel[Daten.zs.sel$Nr.signif.res >= 8,]

## ENSEMBLE IDs mit mind. 7 sig. Ergebnissen
Daten.zs.sel[Daten.zs.sel$Nr.signif.res >= 7,]

## ENSEMBLE IDs mit mind. 6 sig. Ergebnissen
Daten.zs.sel[Daten.zs.sel$Nr.signif.res >= 6,]

## ENSEMBLE IDs mit mind. 5 sig. Ergebnissen
Daten.zs.sel[Daten.zs.sel$Nr.signif.res >= 5,]

## ENSEMBLE IDs mit mind. 4 sig. Ergebnissen
Daten.zs.sel[Daten.zs.sel$Nr.signif.res >= 4,]

## Excel-Tabellen anlegen
library(openxlsx)
write.xlsx(Daten.zs, file = "Ergebnisse_alle.xlsx")
write.xlsx(Daten.zs.sel, file = "Ergebnisse_sel.xlsx")
