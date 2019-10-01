### Replication File for "Project Design Decisions of Egalitarian and Non-Egalitarian International Organizations: Evidence from the Global Environment Facility and the World Bank" ###

# Alice Iannantuoni, Charla Waeiss, and Matthew S. Winters 

# Variables for the GEF analyses are described in the text; see corresponding regression tables. Variables for the World Bank analysis are described below. #

######################
# R Code for Figures #
######################

library(tidyverse)
library(reshape2)
library(gridExtra)

# 1. Load replication data file.

# a. From working directory:
data = read_csv("ReplicationFile20190918.csv")


# 2. Figure 1

# a. Make data frame for use in plotting.
df_1 = tibble(
  group=c("Replication","Authors"),
  GEF=c(
    data$gef_grant[data$gef_id==1125],
    data$iwwgef_grant[data$gef_id==1125]
  ),
  IA=c(
    0,
    data$iwwia_funding[data$gef_id==1125]
  ), 
  Foreign=c(
    0,
    data$iwwforeign_funding[data$gef_id==1125]
  ),
  Recipient=c(
    0,
    data$iwwrecipient_funding[data$gef_id==1125]
  ),
  Cofinancing=c(
    data$cofinancing_total[data$gef_id==1125],
    0
  ),
  Total=c(
    data$project_total[data$gef_id==1125],
    data$iwwcoded_sum[data$gef_id==1125]
  )
) %>%
  mutate_if(is.numeric, function(x) x/.$Total) %>%
  select(-Total) %>%
  melt %>%
  mutate(value = round(value*100, digits = 1),
         group = factor(group, levels = c("Replication","Authors"))) %>%
  group_by(group) %>%
  mutate(pos = 100 - (cumsum(value) - 0.5*value))
df_1$pos[df_1$value==0] = NA

# b. Make plot.
df_1 %>%
  ggplot(
    aes(x = group, y = value, fill = variable)
  ) +
  geom_col() +
  geom_text(
    aes(y = pos, 
        label = paste0(value,"%")),
    size = 4
  ) +
  coord_polar(theta = "y") +
  theme_void() +
  scale_fill_grey(
    start = 0.5,
    end = 0.9
  ) + 
  labs(
    x = "",
    y = "",
    fill = ""
  ) + 
  annotate(
    "text",
    x = 1.5, y = 1,
    label = "Original Data",
    size = 4
  ) + 
  annotate(
    "text",
    x = 2.5, y = 1,
    label = "Authors' Data",
    size = 4
  )


# 3. Figure 2

# a. Recode iwwibrd to specify 'World Bank' or 'Non-World Bank'.
data$iwwibrd.desc = ifelse(
  data$iwwibrd==1, "World Bank", "Non-World Bank"
)
data.gefia=subset(data, !is.na(data$iwwgef_pct) & !is.na(data$iwwia_pct))

# b. Make individual density plots.
F2a = ggplot(data, aes(x = iwwgef_pct, fill = iwwibrd.desc)) +
  geom_density(alpha=0.5) +
  labs(x="GEF / Total (%)", y="Density", title="") +
  theme_bw() + 
  scale_fill_grey(name="Implementing Agency") +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"), 
        legend.position = c(0.8,0.8))

F2b = ggplot(data, aes(x=iwwallexternal_pct, fill=iwwibrd.desc)) +
  geom_density(alpha=0.5) +
  labs(x="External / Total (%)", y="Density", title="") +
  theme_bw() + 
  scale_fill_grey(name="Implementing Agency") +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"), 
        legend.position = c(0.2,0.8))

F2c = ggplot(data.gefia, aes(x=iwwgefia_pct, fill=iwwibrd.desc)) +
  geom_density(alpha=0.5) +
  labs(x="GEF + IA / Total (%)", y="Density", title="") +
  theme_bw() +
  scale_fill_grey(name="Implementing Agency") + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"), 
        legend.position = c(0.75,0.85))

F2d = ggplot(data, aes(x=iwwia_pct, fill=iwwibrd.desc)) +
  geom_density(alpha=0.5) +
  labs(x="IA / Total (%)", y="Density", title="") +
  theme_bw() +
  scale_fill_grey(name="Implementing Agency") + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"), 
        legend.position = c(0.75,0.8))

F2e = ggplot(data, aes(x=iwwforeign_pct, fill=iwwibrd.desc)) + 
  geom_density(alpha=0.5) +
  labs(x="Foreign / Total (%)", y="Density", title="") +
  theme_bw() +
  scale_fill_grey(name="Implementing Agency") + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"), 
        legend.position = c(0.75,0.8))

F2f = ggplot(data, aes(x=iwwrecipient_pct, fill=iwwibrd.desc)) +
  geom_density(alpha=0.5) +
  labs(x="Recipient / Total (%)", y="Density", title="") +
  theme_bw() +
  scale_fill_grey(name="Implementing Agency") + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"), 
        legend.position = c(0.75,0.85))

# c. Arrange in single figure
gridExtra::grid.arrange(F2a, F2b, F2c, F2d, F2e, F2f, ncol=2)


# 4. Figure 3

# a. Generate data frame for use in plotting. Show total along the way.
# AVERAGE PROJECT WITH BREAKDOWN (N = 1,256)
sum(data$iwwviableproj==1,na.rm=T)
avg.GEF = mean(data$iwwgef_pct[data$iwwviableproj==1],na.rm=T) 
avg.IA = mean(data$iwwia_pct[data$iwwviableproj==1],na.rm=T)
avg.foreign = mean(data$iwwforeign_pct[data$iwwviableproj==1],na.rm=T)
avg.recipient = mean(data$iwwrecipient_pct[data$iwwviableproj==1],na.rm=T)

# AVERAGE WB PROJECT WITH BREAKDOWN (N = 450)
sum(data$iwwviableproj==1 & data$iwwibrd,na.rm=T)
WB.GEF = mean(data$iwwgef_pct[data$iwwviableproj==1 & data$iwwibrd==1],na.rm=T) 
WB.IA = mean(data$iwwia_pct[data$iwwviableproj==1 & data$iwwibrd==1],na.rm=T)
WB.foreign = mean(data$iwwforeign_pct[data$iwwviableproj==1 & data$iwwibrd==1],na.rm=T)
WB.recipient = mean(data$iwwrecipient_pct[data$iwwviableproj==1 & data$iwwibrd==1],na.rm=T)

# AVERAGE Non-WB PROJECT WITH BREAKDOWN (N = 806)
sum(data$iwwviableproj==1 & data$iwwibrd==0,na.rm=T)
NonWB.GEF = mean(data$iwwgef_pct[data$iwwviableproj==1 & data$iwwibrd==0],na.rm=T) 
NonWB.IA = mean(data$iwwia_pct[data$iwwviableproj==1 & data$iwwibrd==0],na.rm=T)
NonWB.foreign = mean(data$iwwforeign_pct[data$iwwviableproj==1 & data$iwwibrd==0],na.rm=T)
NonWB.recipient = mean(data$iwwrecipient_pct[data$iwwviableproj==1 & data$iwwibrd==0],na.rm=T)

# AVERAGE Dev Bank PROJECT WITH BREAKDOWN (N = 499)
sum(data$iwwviableproj==1 & data$iwwdevbnk==1,na.rm=T)
DB.GEF = mean(data$iwwgef_pct[data$iwwviableproj==1 & data$iwwdevbnk==1],na.rm=T) 
DB.IA = mean(data$iwwia_pct[data$iwwviableproj==1 & data$iwwdevbnk==1],na.rm=T)
DB.foreign = mean(data$iwwforeign_pct[data$iwwviableproj==1 & data$iwwdevbnk==1],na.rm=T)
DB.recipient = mean(data$iwwrecipient_pct[data$iwwviableproj==1 & data$iwwdevbnk==1],na.rm=T)

# AVERAGE Non-Dev Bank PROJECT WITH BREAKDOWN (N = 757)
sum(data$iwwviableproj==1 & data$iwwdevbnk==0,na.rm=T)
NonDB.GEF = mean(data$iwwgef_pct[data$iwwviableproj==1 & data$iwwdevbnk==0],na.rm=T) 
NonDB.IA = mean(data$iwwia_pct[data$iwwviableproj==1 & data$iwwdevbnk==0],na.rm=T)
NonDB.foreign = mean(data$iwwforeign_pct[data$iwwviableproj==1 & data$iwwdevbnk==0],na.rm=T)
NonDB.recipient = mean(data$iwwrecipient_pct[data$iwwviableproj==1 & data$iwwdevbnk==0],na.rm=T)

df_3 = tibble(
  group = c("Average","WB","NonWB","DB","NonDB"),
  GEF = c(avg.GEF,WB.GEF,NonWB.GEF,DB.GEF,NonDB.GEF),
  IA = c(avg.IA,WB.IA,NonWB.IA,DB.IA,NonDB.IA), 
  Foreign = c(avg.foreign,WB.foreign,NonWB.foreign,DB.foreign,NonDB.foreign),
  Recipient = c(avg.recipient,WB.recipient,NonWB.recipient,DB.recipient,NonDB.recipient)
) %>%
  melt %>%
  mutate(value = round(value, digits=1),
         group = factor(group, 
                        levels = c("NonDB","DB","NonWB","WB","Average"),
                        labels = c("Average UN Project","Average Dev Bnk Project",
                                   "Average Non-WB Project","Average WB Project",
                                   "Average Project"))) %>%
  group_by(group) %>%
  mutate(pos = 100 - (cumsum(value) - 0.5*value))

# b. Make plot.
ggplot(df_3, aes(fill=variable, y=value, x=group)) +
  geom_bar(stat="identity", width=.5, position=position_stack(reverse = TRUE)) +
  geom_text(aes(y=(100-pos), label = paste0(value,"%")), size=5) +
  theme_classic() +
  scale_fill_grey(
    start = 0.5,
    end = 0.9
  ) +
  coord_flip() +
  theme(legend.position="bottom", legend.direction="horizontal",
        legend.title = element_blank()) + 
  labs(y="Average Share of Total Project Cost", x="")


# 5. Figure 4

# a. Estimate models to obtain predicted values.
dat = data %>%
  mutate(year=as.factor(year))
names(dat) = tolower(names(dat))

# Models 5,6,11,12,13,14
# all with interaction
mod5int = lm(iwwgef_pct~ lngdpcon*ibrd
             + climate + iwwlncoded_sum + democracy + corrupt 
             + easiap + soasia + mideana + wneurope + europeca + latamcar + namerica 
             + year, dat)
mod6int = lm(iwwgef_pct~ iwwlncapgdp2000*ibrd
             + climate + iwwlncoded_sum + democracy + corrupt 
             + easiap + soasia + mideana + wneurope + europeca + latamcar + namerica 
             + year, dat)
mod11int = lm(iwwia_pct~ lngdpcon*ibrd
              + climate + iwwlncoded_sum + democracy + corrupt 
              + easiap + soasia + mideana + wneurope + europeca + latamcar + namerica 
              + year, dat)
mod12int = lm(iwwia_pct~ iwwlncapgdp2000*ibrd
              + climate + iwwlncoded_sum + democracy + corrupt 
              + easiap + soasia + mideana + wneurope + europeca + latamcar + namerica 
              + year, dat)
mod13int = lm(iwwforeign_pct~ lngdpcon*ibrd
              + climate + iwwlncoded_sum + democracy + corrupt 
              + easiap + soasia + mideana + wneurope + europeca + latamcar + namerica 
              + year, dat)
mod14int = lm(iwwforeign_pct~ iwwlncapgdp2000*ibrd
              + climate + iwwlncoded_sum + democracy + corrupt 
              + easiap + soasia + mideana + wneurope + europeca + latamcar + namerica 
              + year, dat)
mod15int = lm(iwwrecipient_pct~ lngdpcon*ibrd
              + climate + iwwlncoded_sum + democracy + corrupt 
              + easiap + soasia + mideana + wneurope + europeca + latamcar + namerica 
              + year, dat)
mod16int = lm(iwwrecipient_pct~ iwwlncapgdp2000*ibrd
              + climate + iwwlncoded_sum + democracy + corrupt 
              + easiap + soasia + mideana + wneurope + europeca + latamcar + namerica 
              + year, dat)

# b. Make data frame for use in plotting.
new_dat = mod5int$model %>% 
  map_dfc(~rep(mean(.),len=4)) %>%
  mutate(lngdpcon=rep(c(quantile(mod5int$model$lngdpcon,.25),
                        quantile(mod5int$model$lngdpcon,.75)),len=4),
         ibrd=c(0,0,1,1),
         year=as.factor("2000")) 
preds5int = predict.lm(mod5int,new_dat)

new_dat = mod6int$model %>% 
  map_dfc(~rep(mean(.),len=4)) %>%
  mutate(iwwlncapgdp2000=rep(c(quantile(mod6int$model$iwwlncapgdp2000,.25),
                               quantile(mod6int$model$iwwlncapgdp2000,.75)),len=4),
         ibrd=c(0,0,1,1),
         year=as.factor("2000"))

preds6int = predict.lm(mod6int,new_dat)
new_dat = mod11int$model %>% 
  map_dfc(~rep(mean(.),len=4)) %>%
  mutate(lngdpcon=rep(c(quantile(mod11int$model$lngdpcon,.25),
                        quantile(mod11int$model$lngdpcon,.75)),len=4),
         ibrd=c(0,0,1,1),
         year=as.factor("2000")) 
preds11int = predict.lm(mod11int,new_dat)
new_dat = mod12int$model %>% 
  map_dfc(~rep(mean(.),len=4)) %>%
  mutate(iww.lncapgdp2000=rep(c(quantile(mod12int$model$iww.lncapgdp2000,.25),
                                quantile(mod12int$model$iww.lncapgdp2000,.75)),len=4),
         ibrd=c(0,0,1,1),
         year=as.factor("2000"))
preds12int = predict.lm(mod12int,new_dat)

new_dat = mod13int$model %>% 
  map_dfc(~rep(mean(.),len=4)) %>%
  mutate(lngdpcon=rep(c(quantile(mod13int$model$lngdpcon,.25),
                        quantile(mod13int$model$lngdpcon,.75)),len=4),
         ibrd=c(0,0,1,1),
         year=as.factor("2000")) 
preds13int = predict.lm(mod13int,new_dat)
new_dat = mod14int$model %>% 
  map_dfc(~rep(mean(.),len=4)) %>%
  mutate(iwwlncapgdp2000=rep(c(quantile(mod14int$model$iwwlncapgdp2000,.25),
                               quantile(mod14int$model$iwwlncapgdp2000,.75)),len=4),
         ibrd=c(0,0,1,1),
         year=as.factor("2000"))
preds14int = predict.lm(mod14int,new_dat)
new_dat = mod15int$model %>% 
  map_dfc(~rep(mean(.),len=4)) %>%
  mutate(lngdpcon=rep(c(quantile(mod15int$model$lngdpcon,.25),
                        quantile(mod15int$model$lngdpcon,.75)),len=4),
         ibrd=c(0,0,1,1),
         year=as.factor("2000")) 
preds15int = predict.lm(mod15int,new_dat)
new_dat = mod16int$model %>% 
  map_dfc(~rep(mean(.),len=4)) %>%
  mutate(iwwlncapdgp2000=rep(c(quantile(mod16int$model$iwwlncapgdp2000,.25),
                               quantile(mod16int$model$iwwlncapgdp2000,.75)),len=4),
         ibrd=c(0,0,1,1),
         year=as.factor("2000"))
preds16int = predict.lm(mod16int,new_dat)
preds_tot =  rbind(
  data.frame(fit = preds5int) %>%
    mutate(value=rep(c("25% GDP","75% GDP"),len=4),
           ibrd=c("Non-WB","Non-WB","WB","WB"),
           pred="GEF"),
  data.frame(fit = preds6int) %>%
    mutate(value=rep(c("25% GDPpc","75% GDPpc"),len=4),
           ibrd=c("Non-WB","Non-WB","WB","WB"),
           pred="GEF"),
  data.frame(fit = preds11int) %>%
    mutate(value=rep(c("25% GDP","75% GDP"),len=4),
           ibrd=c("Non-WB","Non-WB","WB","WB"),
           pred="IA"),
  data.frame(fit = preds12int) %>%
    mutate(value=rep(c("25% GDPpc","75% GDPpc"),len=4),
           ibrd=c("Non-WB","Non-WB","WB","WB"),
           pred="IA"),
  data.frame(fit = preds13int) %>%
    mutate(value=rep(c("25% GDP","75% GDP"),len=4),
           ibrd=c("Non-WB","Non-WB","WB","WB"),
           pred="Foreign"),
  data.frame(fit = preds14int) %>%
    mutate(value=rep(c("25% GDPpc","75% GDPpc"),len=4),
           ibrd=c("Non-WB","Non-WB","WB","WB"),
           pred="Foreign"),
  data.frame(fit = preds15int) %>%
    mutate(value=rep(c("25% GDP","75% GDP"),len=4),
           ibrd=c("Non-WB","Non-WB","WB","WB"),
           pred="Recipient"),
  data.frame(fit = preds16int) %>%
    mutate(value=rep(c("25% GDPpc","75% GDPpc"),len=4),
           ibrd=c("Non-WB","Non-WB","WB","WB"),
           pred="Recipient")) %>%
  mutate(group=paste(value,ibrd,sep=": "),
         pred=factor(pred,level=c("GEF","IA","Foreign","Recipient")),
         group=factor(
           group,
           level=c(
             "25% GDPpc: Non-WB",
             "75% GDPpc: Non-WB",
             "25% GDP: Non-WB",
             "75% GDP: Non-WB",
             "25% GDPpc: WB",
             "75% GDPpc: WB",
             "25% GDP: WB",
             "75% GDP: WB"
           )
         ))

# c. Make plot
preds_tot %>% 
  group_by(value,ibrd) %>% 
  mutate(fit = 100*(fit/sum(fit))) %>%
  group_by(group) %>%
  mutate(pos = cumsum(fit) - 0.5*fit) %>%
  ggplot(aes(x=group,y=fit,fill=pred)) +
  geom_col(position = position_stack(reverse = T)) +
  geom_text(aes(label = paste0(round(fit,1),"%"),
                y = pos), size=5) +
  theme_classic() +
  scale_fill_grey(
    start = 0.5,
    end = 0.9
  ) +
  coord_flip() +
  theme(legend.position="bottom", legend.direction="horizontal",
        legend.title = element_blank()) + 
  labs(y="Predicted Share of Total Project Cost", x="") 


# 6. Figure A1

# a. Recode values for plotting
data$iwwdevbnk.desc=ifelse(data$iwwdevbnk==1, "Development Banks", "UN Agencies")
data.gefia=subset(data, !is.na(data$iwwgef_pct) & !is.na(data$iwwia_pct))

# b. Make individual density plots.
FA1a = ggplot(data, aes(x=iwwgef_pct, 
                        fill=forcats::fct_rev(iwwdevbnk.desc))) +
  geom_density(alpha=0.5) +
  labs(x="GEF / Total (%)", y="Density", title="") +
  theme_bw() + 
  scale_fill_grey(name="Implementing Agency") +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"), 
        legend.position = c(0.8,0.8))

FA1b = ggplot(data, aes(x=iwwallexternal_pct, 
                        fill=forcats::fct_rev(iwwdevbnk.desc))) +
  geom_density(alpha=0.5) +
  labs(x="External / Total (%)", y="Density", title="") +
  theme_bw() + 
  scale_fill_grey(name="Implementing Agency") +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"), 
        legend.position = c(0.2,0.8))

FA1c = ggplot(data.gefia, aes(x=iwwgefia_pct, 
                              fill=forcats::fct_rev(iwwdevbnk.desc))) +
  geom_density(alpha=0.5) +
  labs(x="GEF + IA / Total (%)", y="Density", title="") +
  theme_bw() +
  scale_fill_grey(name="Implementing Agency") + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"), 
        legend.position = c(0.75,0.85))

FA1d = ggplot(data, aes(x=iwwia_pct, 
                        fill=forcats::fct_rev(iwwdevbnk.desc))) +
  geom_density(alpha=0.5) +
  labs(x="IA / Total (%)", y="Density", title="") +
  theme_bw() +
  scale_fill_grey(name="Implementing Agency") + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"), 
        legend.position = c(0.75,0.8))

FA1e = ggplot(data, aes(x=iwwforeign_pct, 
                        fill=forcats::fct_rev(iwwdevbnk.desc))) + 
  geom_density(alpha=0.5) +
  labs(x="Foreign / Total (%)", y="Density", title="") +
  theme_bw() +
  scale_fill_grey(name="Implementing Agency") + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"), 
        legend.position = c(0.75,0.8))

FA1f = ggplot(data, aes(x=iwwrecipient_pct, 
                        fill=forcats::fct_rev(iwwdevbnk.desc))) +
  geom_density(alpha=0.5) +
  labs(x="Recipient / Total (%)", y="Density", title="") +
  theme_bw() +
  scale_fill_grey(name="Implementing Agency") + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"), 
        legend.position = c(0.75,0.85))

# c. Arrange in single figure
gridExtra::grid.arrange(FA1a, FA1b, FA1c, FA1d, FA1e, FA1f, ncol=2)



# 7. Figure A2

# Plot with same date used for Figure 4.
preds_tot %>% 
  group_by(group) %>%
  mutate(pos = cumsum(fit) - 0.5*fit) %>%
  ggplot(aes(x=group,y=fit,fill=pred)) +
  geom_col(position = position_stack(reverse = T)) +
  geom_text(aes(label = paste0(round(fit,1),"%"),
                y = pos), size=5) +
  theme_classic() +
  scale_fill_grey(
    start = 0.5,
    end = 0.9
  ) +
  coord_flip() +
  theme(legend.position="bottom", legend.direction="horizontal",
        legend.title = element_blank()) + 
  labs(y="Predicted Share of Total Project Cost", x="") 

