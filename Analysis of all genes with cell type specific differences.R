load("Results_GSE56787celllines.RData")
load("ResultsGSE123468_Fam12.RData")
load("ResultsGSE123468_Fam16.RData")


names(res.GSE56787celllines) <- paste0("GSE56787celllines.", names(res.GSE56787celllines))
names(res.GSE123468_12) <- paste0("GSE123468_12.", names(res.GSE123468_12))
names(res.GSE123468_16) <- paste0("GSE123468_16.", names(res.GSE123468_16))

## adj. p value < 0.05
res.GSE56787celllines.sel <- res.GSE56787celllines[res.GSE56787celllines$`GSE56787celllines.group:celltype: adj.P.Val` < 0.05,]
res.GSE123468_12.sel <- res.GSE123468_12[res.GSE123468_12$`GSE123468_12.group:celltype12: adj.P.Val` < 0.05,]
res.GSE123468_16.sel <- res.GSE123468_16[res.GSE123468_16$`GSE123468_16.group:celltype16: adj.P.Val` < 0.05,]

dim(res.GSE56787celllines.sel)
dim(res.GSE123468_12.sel)
Daten.zs <- merge(res.GSE56787celllines.sel, res.GSE123468_12.sel, by.x = "GSE56787celllines.ENSEMBLE",
                  by.y = "GSE123468_12.ENSEMBLE", all = TRUE)
dim(res.GSE123468_16.sel)
Daten.zs <- merge(Daten.zs, res.GSE123468_16.sel, by.x = "GSE56787celllines.ENSEMBLE", 
                  by.y = "GSE123468_16.ENSEMBLE", all = TRUE)

Daten.zs$Nr.signif.res <- rowSums(Daten.zs[,c("GSE56787celllines.group:celltype: adj.P.Val", 
                                              "GSE123468_12.group:celltype12: adj.P.Val",
                                              "GSE123468_16.group:celltype16: adj.P.Val")] < 0.05, na.rm = TRUE)
Daten.zs <- Daten.zs[order(Daten.zs$Nr.signif.res, decreasing = TRUE),]
head(Daten.zs, n = 20)

Daten.zs.sel <- Daten.zs[,c("GSE56787celllines.ENSEMBLE", "Nr.signif.res")]
Daten.zs.sel <- Daten.zs.sel[!duplicated(Daten.zs.sel),]

## Keine ENSEMBLE ID???
sum(is.na(Daten.zs.sel$GSE56787celllines.ENSEMBLE))
Daten.zs.sel[is.na(Daten.zs.sel$GSE56787celllines.ENSEMBLE),]

Daten.zs.sel <- Daten.zs.sel[!is.na(Daten.zs.sel$GSE56787celllines.ENSEMBLE),]
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
  sel <- which(gnsIDs$gene_id == Daten.zs.sel$GSE56787celllines.ENSEMBLE[i])
  if(length(sel) == 0){
    print(gnsIDs$gene_name[sel])
    print(Daten.zs.sel$GSE56787celllines.ENSEMBLE[i])
  }
  if(length(sel) > 1){
    print(gnsIDs$gene_name[sel])
    print(Daten.zs.sel$GSE56787celllines.ENSEMBLE[i])
  }
    
  Daten.zs.sel$gene_name[i] <- gnsIDs$gene_name[sel[1]]
}

## nur noch ein paar wenige doppelte ENSEMBLE IDs
sort(table(Daten.zs.sel$GSE56787celllines.ENSEMBLE), decreasing = TRUE)[1:20]

## ENSEMBLE IDs mit 7 sig. Ergebnissen
Daten.zs.sel[Daten.zs.sel$Nr.signif.res >= 3,]

## ENSEMBLE IDs mit mind. 6 sig. Ergebnissen
Daten.zs.sel[Daten.zs.sel$Nr.signif.res >= 2,]



## Excel-Tabellen anlegen
library(openxlsx)
write.xlsx(Daten.zs, file = "Ergebnisse_alle.xlsx")
write.xlsx(Daten.zs.sel, file = "Ergebnisse_sel.xlsx")
