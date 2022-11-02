load("GO.DN_GSE56787celllines_rescelltypegroup.RData")
load("GO.DN_GSE123468_group&celltype_Fam12.RData")
load("GO.DN_GSE123468_group&celltype_Fam16.RData")

names(go.dn.GSE56787celllines) <- paste0("GSE56787celllines.", names(go.dn.GSE56787celllines))
names(go.dn.GSE123468_12c) <- paste0("GSE123468_12c.", names(go.dn.GSE123468_12c))
names(go.dn.GSE123468_16c) <- paste0("GSE123468_16c.", names(go.dn.GSE123468_16c))

## adj. p value < 0.05
go.dn.GSE56787celllines.sel <- go.dn.GSE56787celllines[go.dn.GSE56787celllines$GSE56787celllines.P.Down < 0.05,]
go.dn.GSE123468_12c.sel <- go.dn.GSE123468_12c[go.dn.GSE123468_12c$GSE123468_12c.P.Down < 0.05,]
go.dn.GSE123468_16c.sel <- go.dn.GSE123468_16c[go.dn.GSE123468_16c$GSE123468_16c.P.Down < 0.05,]

dim(go.dn.GSE56787celllines.sel)
dim(go.dn.GSE123468_12c.sel)
Daten.zs <- merge(go.dn.GSE56787celllines.sel, go.dn.GSE123468_12c.sel, by.x = "GSE56787celllines.Term",
                  by.y = "GSE123468_12c.Term", all = TRUE)
dim(go.dn.GSE123468_16c.sel)
Daten.zs <- merge(Daten.zs, go.dn.GSE123468_16c.sel, by.x = "GSE56787celllines.Term", 
                  by.y = "GSE123468_16c.Term", all = TRUE)


Daten.zs$Nr.signif.go.dn <- rowSums(Daten.zs[,c("GSE56787celllines.P.Down",
                                              "GSE123468_12c.P.Down",
                                              "GSE123468_16c.P.Down")] < 0.05, na.rm = TRUE)

Daten.zs <- Daten.zs[order(Daten.zs$Nr.signif.go.dn, decreasing = TRUE),]
head(Daten.zs, n = 20)

Daten.zs.sel <- Daten.zs[,c("GSE56787celllines.Term", "Nr.signif.go.dn")]
Daten.zs.sel <- Daten.zs.sel[!duplicated(Daten.zs.sel),]

## Keine Term ID???
sum(is.na(Daten.zs.sel$GSE56787celllines.Term))
Daten.zs.sel[is.na(Daten.zs.sel$GSE56787celllines.Term),]

Daten.zs.sel <- Daten.zs.sel[!is.na(Daten.zs.sel$GSE56787celllines.Term),]
head(Daten.zs.sel, n = 20)


## nur noch ein paar wenige doppelte Term IDs
sort(table(Daten.zs.sel$GSE56787celllines.Term), decreasing = TRUE)[1:20]

## Term IDs mit 3 sig. Ergebnissen
Daten.zs.sel[Daten.zs.sel$Nr.signif.go.dn >= 3,]

## Term IDs mit mind. 2 sig. Ergebnissen
Daten.zs.sel[Daten.zs.sel$Nr.signif.go.dn >= 2,]

## Term IDs mit mind. 1 sig. Ergebnissen
Daten.zs.sel[Daten.zs.sel$Nr.signif.go.dn >= 1,]


## Excel-Tabellen anlegen
library(openxlsx)
write.xlsx(Daten.zs, file = "Ergebnisse_alle.xlsx")
write.xlsx(Daten.zs.sel, file = "Ergebnisse_sel.xlsx")

