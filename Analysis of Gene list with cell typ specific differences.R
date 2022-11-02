load("ResultsGeneSel_GSE26061.RData")
load("ResultsGeneSel_GSE26145.RData")
load("ResultsGeneSel_GSE56787celllines.RData")
load("ResultsGeneSel_GSE123468_Fam12.RData")
load("ResultsGeneSel_GSE123468_Fam16.RData")

names(res.GeneSel.GSE26061) <- paste0("GeneSel.GSE26061", names(res.GeneSel.GSE26061))
names(res.GeneSel.GSE26145) <- paste0("GeneSel.GSE26145", names(res.GeneSel.GSE26145))
names(res.GeneSel.GSE56787celllines) <- paste0("GeneSel.GSE56787celllines", names(res.GeneSel.GSE56787celllines))
names(res.GeneSel.GSE123468_12) <- paste0("GeneSel.GSE123468_12.", names(res.GeneSel.GSE123468_12))
names(res.GeneSel.GSE123468_16) <- paste0("GeneSel.GSE123468_16.", names(res.GeneSel.GSE123468_16))


## adj. p value < 0.05
res.GeneSel.GSE26061.sel <- res.GeneSel.GSE26061[res.GeneSel.GSE26061$`GeneSel.GSE26061group:celltype: adj.P.Val` < 0.05,]
res.GeneSel.GSE26145.sel <- res.GeneSel.GSE26145[res.GeneSel.GSE26145$`GeneSel.GSE26145group:celltype: adj.P.Val` < 0.05,]
res.GeneSel.GSE56787celllines.sel <- res.GeneSel.GSE56787celllines[res.GeneSel.GSE56787celllines$`GeneSel.GSE56787celllinesgroup:celltype: adj.P.Val` < 0.05,]
res.GeneSel.GSE123468_12.sel <- res.GeneSel.GSE123468_12[res.GeneSel.GSE123468_12$`GeneSel.GSE123468_12.group:celltype12: adj.P.Val` < 0.05,]
res.GeneSel.GSE123468_16.sel <- res.GeneSel.GSE123468_16[res.GeneSel.GSE123468_16$`GeneSel.GSE123468_16.group:celltype16: adj.P.Val` < 0.05,]


dim(res.GeneSel.GSE123468_12.sel)
dim(res.GeneSel.GSE123468_16.sel)
Daten.zs <- merge(res.GeneSel.GSE123468_12.sel, res.GeneSel.GSE123468_16.sel, by.x = "GeneSel.GSE123468_12.ENSEMBLE",
                  by.y = "GeneSel.GSE123468_16.ENSEMBLE", all = TRUE)


dim(res.GeneSel.GSE26061.sel)
Daten.zs <- merge(Daten.zs,res.GeneSel.GSE26061.sel, by.x = "GeneSel.GSE123468_12.ENSEMBLE",
                  by.y = "GeneSel.GSE26061ENSEMBL", all = TRUE)
dim(res.GeneSel.GSE26145.sel)
Daten.zs <- merge(Daten.zs,res.GeneSel.GSE26145.sel, by.x = "GeneSel.GSE123468_12.ENSEMBLE",
                  by.y = "GeneSel.GSE26145ENSEMBL", all = TRUE)


dim(res.GeneSel.GSE56787celllines.sel)
Daten.zs <- merge(Daten.zs,res.GeneSel.GSE56787celllines.sel, by.x = "GeneSel.GSE123468_12.ENSEMBLE",
                  by.y = "GeneSel.GSE56787celllinesENSEMBLE", all = TRUE)



Daten.zs$Nr.signif.res <- rowSums(Daten.zs[,c("GeneSel.GSE26061group:celltype: adj.P.Val",
                                              "GeneSel.GSE26145group:celltype: adj.P.Val",
                                              "GeneSel.GSE56787celllinesgroup:celltype: adj.P.Val",
                                              "GeneSel.GSE123468_12.group:celltype12: adj.P.Val",
                                              "GeneSel.GSE123468_16.group:celltype16: adj.P.Val")] < 0.05, na.rm = TRUE)



Daten.zs <- Daten.zs[order(Daten.zs$Nr.signif.res, decreasing = TRUE),]
head(Daten.zs, n = 20)

Daten.zs.sel <- Daten.zs[,c("GeneSel.GSE123468_12.ENSEMBLE", "Nr.signif.res")]
Daten.zs.sel <- Daten.zs.sel[!duplicated(Daten.zs.sel),]

## Keine ENSEMBLE ID???
sum(is.na(Daten.zs.sel$GeneSel.GSE123468_12.ENSEMBLE))
Daten.zs.sel[is.na(Daten.zs.sel$GeneSel.GSE123468_12.ENSEMBLE),]

Daten.zs.sel <- Daten.zs.sel[!is.na(Daten.zs.sel$GeneSel.GSE123468_12.ENSEMBLE),]
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
  sel <- which(gnsIDs$gene_id == Daten.zs.sel$GeneSel.GSE123468_12.ENSEMBLE[i])
  if(length(sel) == 0){
    print(gnsIDs$gene_name[sel])
    print(Daten.zs.sel$GeneSel.GSE123468_12.ENSEMBLE[i])
  }
  if(length(sel) > 1){
    print(gnsIDs$gene_name[sel])
    print(Daten.zs.sel$GeneSel.GSE123468_12.ENSEMBLE[i])
  }
    
  Daten.zs.sel$gene_name[i] <- gnsIDs$gene_name[sel[1]]
}

## nur noch ein paar wenige doppelte ENSEMBLE IDs
sort(table(Daten.zs.sel$GeneSel.GSE123468_12.ENSEMBLE), decreasing = TRUE)[1:20]

## ENSEMBLE IDs mit 4 sig. Ergebnissen
Daten.zs.sel[Daten.zs.sel$Nr.signif.res >= 4,]

## ENSEMBLE IDs mit mind. 3 sig. Ergebnissen
Daten.zs.sel[Daten.zs.sel$Nr.signif.res >= 3,]

## ENSEMBLE IDs mit mind. 2 sig. Ergebnissen
Daten.zs.sel[Daten.zs.sel$Nr.signif.res >= 2,]

## ENSEMBLE IDs mit mind. 1 sig. Ergebnissen
Daten.zs.sel[Daten.zs.sel$Nr.signif.res >= 1,]


## Excel-Tabellen anlegen
library(openxlsx)
write.xlsx(Daten.zs, file = "Ergebnisse_alle.xlsx")
write.xlsx(Daten.zs.sel, file = "Ergebnisse_sel.xlsx")
