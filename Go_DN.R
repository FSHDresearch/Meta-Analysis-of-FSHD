load("GO.DN_EGAD00001008337.RData")
load("GO.DN_GSE10760.RData")
load("GO.DN_GSE115650.RData")
load("GO.DN_GSE123468_groupFam12.RData")
load("GO.DN_GSE123468_groupFam16.RData")
load("GO.DN_GSE138768.RData")
load("GO.DN_GSE26852.RData")

names(go.dn.EGAD00001008337) <- paste0("EGA.", names(go.dn.EGAD00001008337))
names(go.dn.GSE10760) <- paste0("GSE10760.", names(go.dn.GSE10760))
names(go.dn.GSE115650) <- paste0("GSE115650.", names(go.dn.GSE115650))
names(go.dn.GSE123468_12) <- paste0("GSE123468_12.", names(go.dn.GSE123468_12))
names(go.dn.GSE123468_16) <- paste0("GSE123468_16.", names(go.dn.GSE123468_16))
names(go.dn.GSE138768) <- paste0("GSE138768.", names(go.dn.GSE138768))
names(go.dn.GSE26852_stir) <- paste0("GSE26852.", names(go.dn.GSE26852_stir))

## adj. p value < 0.05
go.dn.EGAD00001008337.sel <- go.dn.EGAD00001008337[go.dn.EGAD00001008337$EGA.P.Down < 0.05,]
go.dn.GSE10760.sel <- go.dn.GSE10760[go.dn.GSE10760$GSE10760.P.Down < 0.05,]
go.dn.GSE115650.sel <- go.dn.GSE115650[go.dn.GSE115650$GSE115650.P.Down < 0.05,]
go.dn.GSE123468_12.sel <- go.dn.GSE123468_12[go.dn.GSE123468_12$GSE123468_12.P.Down < 0.05,]
go.dn.GSE123468_16.sel <- go.dn.GSE123468_16[go.dn.GSE123468_16$GSE123468_16.P.Down < 0.05,]
go.dn.GSE138768.sel <- go.dn.GSE138768[go.dn.GSE138768$GSE138768.P.Down < 0.05,]
go.dn.GSE26852.sel <- go.dn.GSE26852_stir[go.dn.GSE26852_stir$GSE26852.P.Down < 0.05,]

dim(go.dn.EGAD00001008337.sel)
dim(go.dn.GSE10760.sel)
Daten.zs <- merge(go.dn.EGAD00001008337.sel, go.dn.GSE10760.sel, by.x = "EGA.Term",
                  by.y = "GSE10760.Term", all = TRUE)
dim(go.dn.GSE115650.sel)
Daten.zs <- merge(Daten.zs, go.dn.GSE115650.sel, by.x = "EGA.Term", 
                  by.y = "GSE115650.Term", all = TRUE)
dim(go.dn.GSE123468_12.sel)
Daten.zs <- merge(Daten.zs, go.dn.GSE123468_12.sel, by.x = "EGA.Term", 
                  by.y = "GSE123468_12.Term", all = TRUE)
dim(go.dn.GSE123468_16.sel)
Daten.zs <- merge(Daten.zs, go.dn.GSE123468_16.sel, by.x = "EGA.Term", 
                  by.y = "GSE123468_16.Term", all = TRUE)
dim(go.dn.GSE138768.sel)
Daten.zs <- merge(Daten.zs, go.dn.GSE138768.sel, by.x = "EGA.Term", 
                  by.y = "GSE138768.Term", all = TRUE)
dim(go.dn.GSE26852.sel)
Daten.zs <- merge(Daten.zs, go.dn.GSE26852.sel, by.x = "EGA.Term", 
                  by.y = "GSE26852.Term", all = TRUE)

Daten.zs$Nr.signif.go.dn <- rowSums(Daten.zs[,c("EGA.P.Down", 
                                              "GSE10760.P.Down",
                                              "GSE115650.P.Down",
                                              "GSE123468_12.P.Down",
                                              "GSE123468_16.P.Down",
                                              "GSE138768.P.Down",
                                              "GSE26852.P.Down")] < 0.05,
                                  na.rm = TRUE)
Daten.zs <- Daten.zs[order(Daten.zs$Nr.signif.go.dn, decreasing = TRUE),]
head(Daten.zs, n = 20)

Daten.zs.sel <- Daten.zs[,c("EGA.Term", "Nr.signif.go.dn")]
Daten.zs.sel <- Daten.zs.sel[!duplicated(Daten.zs.sel),]

## Keine Term ID???
sum(is.na(Daten.zs.sel$EGA.Term))
Daten.zs.sel[is.na(Daten.zs.sel$EGA.Term),]

Daten.zs.sel <- Daten.zs.sel[!is.na(Daten.zs.sel$EGA.Term),]
head(Daten.zs.sel, n = 20)


## nur noch ein paar wenige doppelte Term IDs
sort(table(Daten.zs.sel$EGA.Term), decreasing = TRUE)[1:20]

## Term IDs mit 7 sig. Ergebnissen
Daten.zs.sel[Daten.zs.sel$Nr.signif.go.dn >= 7,]

## Term IDs mit mind. 6 sig. Ergebnissen
Daten.zs.sel[Daten.zs.sel$Nr.signif.go.dn >= 6,]

## Term IDs mit mind. 5 sig. Ergebnissen
Daten.zs.sel[Daten.zs.sel$Nr.signif.go.dn >= 5,]

## Term IDs mit mind. 4 sig. Ergebnissen
Daten.zs.sel[Daten.zs.sel$Nr.signif.go.dn >= 4,]


## Excel-Tabellen anlegen
library(openxlsx)
write.xlsx(Daten.zs, file = "Ergebnisse_alle.xlsx")
write.xlsx(Daten.zs.sel, file = "Ergebnisse_sel.xlsx")

