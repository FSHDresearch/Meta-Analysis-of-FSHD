load("GO.UP_GSE56787celllines_rescelltypegroup.RData")
load("GO.UP_GSE123468_group&celltype_Fam12.RData")
load("GO.UP_GSE123468_group&celltype_Fam16.RData")

names(go.up.GSE56787celllines) <- paste0("GSE56787celllines.", names(go.up.GSE56787celllines))
names(go.up.GSE123468_12c) <- paste0("GSE123468_12c.", names(go.up.GSE123468_12c))
names(go.up.GSE123468_16c) <- paste0("GSE123468_16c.", names(go.up.GSE123468_16c))

## adj. p value < 0.05
go.up.GSE56787celllines.sel <- go.up.GSE56787celllines[go.up.GSE56787celllines$GSE56787celllines.P.Up < 0.05,]
go.up.GSE123468_12c.sel <- go.up.GSE123468_12c[go.up.GSE123468_12c$GSE123468_12c.P.Up < 0.05,]
go.up.GSE123468_16c.sel <- go.up.GSE123468_16c[go.up.GSE123468_16c$GSE123468_16c.P.Up < 0.05,]

dim(go.up.GSE56787celllines.sel)
dim(go.up.GSE123468_12c.sel)
Daten.zs <- merge(go.up.GSE56787celllines.sel, go.up.GSE123468_12c.sel, by.x = "GSE56787celllines.Term",
                  by.y = "GSE123468_12c.Term", all = TRUE)
dim(go.up.GSE123468_16c.sel)
Daten.zs <- merge(Daten.zs, go.up.GSE123468_16c.sel, by.x = "GSE56787celllines.Term", 
                  by.y = "GSE123468_16c.Term", all = TRUE)


Daten.zs$Nr.signif.go.up <- rowSums(Daten.zs[,c("GSE56787celllines.P.Up",
                                              "GSE123468_12c.P.Up",
                                              "GSE123468_16c.P.Up")] < 0.05, na.rm = TRUE)

Daten.zs <- Daten.zs[order(Daten.zs$Nr.signif.go.up, decreasing = TRUE),]
head(Daten.zs, n = 20)

Daten.zs.sel <- Daten.zs[,c("GSE56787celllines.Term", "Nr.signif.go.up")]
Daten.zs.sel <- Daten.zs.sel[!duplicated(Daten.zs.sel),]

## Keine Term ID???
sum(is.na(Daten.zs.sel$GSE56787celllines.Term))
Daten.zs.sel[is.na(Daten.zs.sel$GSE56787celllines.Term),]

Daten.zs.sel <- Daten.zs.sel[!is.na(Daten.zs.sel$GSE56787celllines.Term),]
head(Daten.zs.sel, n = 20)


## nur noch ein paar wenige doppelte Term IDs
sort(table(Daten.zs.sel$GSE56787celllines.Term), decreasing = TRUE)[1:20]

## Term IDs mit 3 sig. Ergebnissen
Daten.zs.sel[Daten.zs.sel$Nr.signif.go.up >= 3,]

## Term IDs mit mind. 2 sig. Ergebnissen
Daten.zs.sel[Daten.zs.sel$Nr.signif.go.up >= 2,]

## Term IDs mit mind. 1 sig. Ergebnissen
Daten.zs.sel[Daten.zs.sel$Nr.signif.go.up >= 1,]


## Excel-Tabellen anlegen
library(openxlsx)
write.xlsx(Daten.zs, file = "Ergebnisse_alle.xlsx")
write.xlsx(Daten.zs.sel, file = "Ergebnisse_sel.xlsx")

