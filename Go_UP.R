load("GO.UP_EGAD00001008337.RData")
load("GO.UP_GSE10760.RData")
load("GO.UP_GSE115650.RData")
load("GO.UP_GSE123468_groupFam12.RData")
load("GO.UP_GSE123468_groupFam16.RData")
load("GO.UP_GSE138768.RData")
load("GO.UP_GSE26852.RData")

names(go.up.EGAD00001008337) <- paste0("EGA.", names(go.up.EGAD00001008337))
names(go.up.GSE10760) <- paste0("GSE10760.", names(go.up.GSE10760))
names(go.up.GSE115650) <- paste0("GSE115650.", names(go.up.GSE115650))
names(go.up.GSE123468_12) <- paste0("GSE123468_12.", names(go.up.GSE123468_12))
names(go.up.GSE123468_16) <- paste0("GSE123468_16.", names(go.up.GSE123468_16))
names(go.up.GSE138768) <- paste0("GSE138768.", names(go.up.GSE138768))
names(go.up.GSE26852_stir) <- paste0("GSE26852.", names(go.up.GSE26852_stir))

## adj. p value < 0.05
go.up.EGAD00001008337.sel <- go.up.EGAD00001008337[go.up.EGAD00001008337$EGA.P.Up < 0.05,]
go.up.GSE10760.sel <- go.up.GSE10760[go.up.GSE10760$GSE10760.P.Up < 0.05,]
go.up.GSE115650.sel <- go.up.GSE115650[go.up.GSE115650$GSE115650.P.Up < 0.05,]
go.up.GSE123468_12.sel <- go.up.GSE123468_12[go.up.GSE123468_12$GSE123468_12.P.Up < 0.05,]
go.up.GSE123468_16.sel <- go.up.GSE123468_16[go.up.GSE123468_16$GSE123468_16.P.Up < 0.05,]
go.up.GSE138768.sel <- go.up.GSE138768[go.up.GSE138768$GSE138768.P.Up < 0.05,]
go.up.GSE26852.sel <- go.up.GSE26852_stir[go.up.GSE26852_stir$GSE26852.P.Up < 0.05,]

dim(go.up.EGAD00001008337.sel)
dim(go.up.GSE10760.sel)
Daten.zs <- merge(go.up.EGAD00001008337.sel, go.up.GSE10760.sel, by.x = "EGA.Term",
                  by.y = "GSE10760.Term", all = TRUE)
dim(go.up.GSE115650.sel)
Daten.zs <- merge(Daten.zs, go.up.GSE115650.sel, by.x = "EGA.Term", 
                  by.y = "GSE115650.Term", all = TRUE)
dim(go.up.GSE123468_12.sel)
Daten.zs <- merge(Daten.zs, go.up.GSE123468_12.sel, by.x = "EGA.Term", 
                  by.y = "GSE123468_12.Term", all = TRUE)
dim(go.up.GSE123468_16.sel)
Daten.zs <- merge(Daten.zs, go.up.GSE123468_16.sel, by.x = "EGA.Term", 
                  by.y = "GSE123468_16.Term", all = TRUE)
dim(go.up.GSE138768.sel)
Daten.zs <- merge(Daten.zs, go.up.GSE138768.sel, by.x = "EGA.Term", 
                  by.y = "GSE138768.Term", all = TRUE)
dim(go.up.GSE26852.sel)
Daten.zs <- merge(Daten.zs, go.up.GSE26852.sel, by.x = "EGA.Term", 
                  by.y = "GSE26852.Term", all = TRUE)

Daten.zs$Nr.signif.go.up <- rowSums(Daten.zs[,c("EGA.P.Up", 
                                              "GSE10760.P.Up",
                                              "GSE115650.P.Up",
                                              "GSE123468_12.P.Up",
                                              "GSE123468_16.P.Up",
                                              "GSE138768.P.Up",
                                              "GSE26852.P.Up")] < 0.05,
                                  na.rm = TRUE)
Daten.zs <- Daten.zs[order(Daten.zs$Nr.signif.go.up, decreasing = TRUE),]
head(Daten.zs, n = 20)

Daten.zs.sel <- Daten.zs[,c("EGA.Term", "Nr.signif.go.up")]
Daten.zs.sel <- Daten.zs.sel[!duplicated(Daten.zs.sel),]

## Keine Term ID???
sum(is.na(Daten.zs.sel$EGA.Term))
Daten.zs.sel[is.na(Daten.zs.sel$EGA.Term),]

Daten.zs.sel <- Daten.zs.sel[!is.na(Daten.zs.sel$EGA.Term),]
head(Daten.zs.sel, n = 20)


## nur noch ein paar wenige doppelte Term IDs
sort(table(Daten.zs.sel$EGA.Term), decreasing = TRUE)[1:20]

## Term IDs mit 7 sig. Ergebnissen
Daten.zs.sel[Daten.zs.sel$Nr.signif.go.up >= 7,]

## Term IDs mit mind. 6 sig. Ergebnissen
Daten.zs.sel[Daten.zs.sel$Nr.signif.go.up >= 6,]

## Term IDs mit mind. 5 sig. Ergebnissen
Daten.zs.sel[Daten.zs.sel$Nr.signif.go.up >= 5,]

## Term IDs mit mind. 4 sig. Ergebnissen
Daten.zs.sel[Daten.zs.sel$Nr.signif.go.up >= 4,]


## Excel-Tabellen anlegen
library(openxlsx)
write.xlsx(Daten.zs, file = "Ergebnisse_alle.xlsx")
write.xlsx(Daten.zs.sel, file = "Ergebnisse_sel.xlsx")

