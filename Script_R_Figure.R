library(ggplot2)
library(scales)
library(ggsignif)

# Multiplot

multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  library(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}

# Genes density plot

data <- read.csv('/home/arthur/Bureau/Article_Genome/Gene_density_plot/Intergenic_EF_SP_MS.txt', sep = '\t', header = T)
colnames(data) <- c('gene','down','up', 'EffectorP', 'SignalP', 'antiSMASH')
ggplot(data) +
    aes(x= up,y=down) +
    #geom_hex()+
    stat_bin2d(binwidth=c(0.06, 0.06))+
    scale_fill_distiller(palette = "Spectral", name="Gene\ncount") +
    scale_x_log10("3' intergenic length (bp)", breaks=c(10,100,1000,10000,100000), labels=c("10", "100", "1,000", "10,000", "100,000"), limits = c(5, 300000))+
    scale_y_log10("5' intergenic length (bp)", breaks=c(10,100,1000,10000,100000), labels=c("10", "100", "1,000", "10,000", "100,000"), limits = c(5, 300000))+
    theme(axis.line = element_line(colour = "black", size = 0.8, linetype = 1))+
    annotation_logticks()+
    #geom_point(data=subset(data, EffectorP == "EFF"), color = 'black', fill = 'yellow',shape = 21,alpha = 0.8, size = 1)
    #geom_point(data=subset(data, SignalP == "SP"), color = 'black', fill = 'blue',shape = 21,alpha = 0.8, size = 1)
    #geom_point(data=subset(data, antiSMASH == "MS"), color = 'black', fill = 'red',shape = 21,alpha = 0.8, size = 1)
    geom_point(data=subset(data, EffectorP == "EFF" & SignalP == "SP"), color = 'black', fill = 'white',shape = 21,alpha = 0.8, size = 1.5)

# Verif moyennes intergenic length :

sum(data$down + data$up) / (nrow(data) * 2)
aggregate(data$down, by=list(Category=data$antiSMASH), FUN=t.test)
aggregate(data$up, by=list(Category=data$antiSMASH), FUN=t.test)
aggregate(data$down, by=list(Category=data$EffectorP), FUN=mean)
aggregate(data$up, by=list(Category=data$EffectorP), FUN=mean)
aggregate(data$down, by=list(Category=data$SignalP), FUN=mean)
aggregate(data$up, by=list(Category=data$SignalP), FUN=mean)
# TEs density plot

data2 <- read.csv('/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/13_Figures_finales/Density_plot_TEs/InterTEs.families.closest.txt', sep = '\t', header = T)
colnames(data2) <- c('TE','down','up','TypeTE','Family','MinimalDistance')
#data2 <- head(data2,310)
ggplot(data2) +
  aes(x= up,y=down) +
  #geom_hex()+
  stat_bin2d(binwidth=c(0.06, 0.06))+
  scale_fill_distiller(palette = "Spectral", name="TE\ncount") +
  scale_x_log10("3' interTE length (bp)", breaks=c(1, 10,100,1000,10000,100000,1000000), labels=c("1", "10", "100", "1,000", "10,000", "100,000", "1,000,000"), limits = c(0.5, 2000000))+
  scale_y_log10("5' interTE length (bp)", breaks=c(1, 10,100,1000,10000,100000,1000000), labels=c("1", "10", "100", "1,000", "10,000", "100,000", "1,000,000"), limits = c(0.5, 2000000))+
  annotation_logticks() +
  #geom_point(data=subset(data2, TypeTE == "DTX" | TypeTE == "DT" | TypeTE == "Crypt1"), color = 'black', fill = 'green3',shape = 21,alpha = 0.8, size = 1.5)+
  theme(axis.line = element_line(colour = "black", size = 0.8, linetype = 1))
  #theme_minimal()

## Violin plots TEs :
# Fonction variance
data_summary <- function(x) {
  m <- mean(x)
  ymin <- m-sqrt(var(x))
  ymax <- m+sqrt(var(x))
  if (ymin < 0) {ymin <- 1}
  return(c(y=m,ymin=ymin,ymax=ymax))
}

data3 = subset(data2, Family != "PotentialHostGene")
ggplot(data3, aes(y = MinimalDistance, x=Family, fill = Family, alpha = 1/10))+
  geom_jitter(shape = 16, position=position_jitter(0.4), size=3, color="lightblue3") +
  geom_violin(color="black")+
  #facet_wrap(~species+secreted, ncol = 4)+
  scale_y_log10(breaks=c(1,10,100,1000,10000,100000,500000), labels=c("1", "10", "100", "1,000", "10,000", "100,000", "500,000"))+
  ylab("Distance to the nearest TE (bp)") +
  xlab("") +
  scale_fill_brewer(palette="Pastel1")+
  stat_summary(fun.data=data_summary, color="grey2") +
  annotation_logticks(sides = "l")+
  theme(axis.line = element_line(colour = "black", size = 0.8, linetype = 1))+
  theme_light()
  #geom_dotplot(aes(y=down,x=Family), binaxis='y', stackdir='center', dotsize=0.1) +

# Violin plots genes distance minimal to TEs:
data4 <- read.csv('/home/arthur/Bureau/Article_Genome/Gene_density_plot/Min_Dist_Gene_to_TE_EF_SP_MS.txt', sep = '\t', header = T)
colnames(data4) <- c('gene','DistToTE','EffectorP', 'SignalP', 'antiSMASH')

# IC 95% 
library(plotrix)
'''
n_obs_NotEFF = sum(data4$EffectorP=="notEFF")
n_obs_EFF = sum(data4$EffectorP=="EFF")
std_notEFF = sd(data4$DistToTE[data4$EffectorP=="notEFF"])
std_EFF = sd(data4$DistToTE[data4$EffectorP=="EFF"])
std.error(data4$DistToTE[data4$EffectorP=="EFF"])

n_obs_NotSP = sum(data4$SignalP=="notSP")
n_obs_SP = sum(data4$SignalP=="SP")
std_notSP = sd(data4$DistToTE[data4$SignalP=="notSP"])
std_SP = sd(data4$DistToTE[data4$SignalP=="SP"])

n_obs_NotMS = sum(data4$antiSMASH=="notMS")
n_obs_MS = sum(data4$antiSMASH=="MS")
std_notMS = sd(data4$DistToTE[data4$antiSMASH=="notMS"])
std_MS = sd(data4$DistToTE[data4$antiSMASH=="MS"])
'''

# Effectors
pa <- ggplot(data4, aes(y = DistToTE, x=EffectorP, fill = EffectorP, alpha = 1/10))+
  geom_jitter(show.legend = FALSE, shape = 16, position=position_jitter(0.4), size=2, color="grey") +
  geom_violin(show.legend = FALSE, color="black")+
  #facet_wrap(~species+secreted, ncol = 4)+
  scale_y_log10(breaks=c(1,10,100,1000,10000,100000,500000,1000000), labels=c("1", "10", "100", "1,000", "10,000", "100,000", "500,000","1,000,000"))+
  scale_x_discrete(limits = c("notEFF", "EFF"), labels=c("Non-Effector", "Effectors"), position = "top") +
  ylab("Distance to the nearest TE (bp)") +
  xlab("") +
  scale_fill_manual(values = c( "#E69F00", "#999999"), name = "")+
  # stat_summary give wrong mean
  #stat_summary(fun=mean, geom="point", color="grey2", show.legend = FALSE)+
  geom_point(aes(x=1, y=mean(data4$DistToTE[data4$EffectorP=="notEFF"])), colour="black", show.legend = FALSE) +
  geom_point(aes(x=2, y=mean(data4$DistToTE[data4$EffectorP=="EFF"])), colour="black", show.legend = FALSE) +
  #geom_rect(aes(xmin = 2, xmax = 2.1, ymin = mean(data4$DistToTE[data4$EffectorP=="EFF"]) - (1.96 / sqrt(n_obs_EFF) * std_EFF), ymax = mean(data4$DistToTE[data4$EffectorP=="EFF"]) + (3.291 / sqrt(n_obs_EFF) * std_EFF)), alpha=0.2, fill="grey") +
  annotation_logticks(sides = "rl")+
  theme(axis.line = element_line(colour = "black", size = 0.8, linetype = 1))+
  geom_signif(comparisons = list(c("notEFF", "EFF")), map_signif_level=TRUE, show.legend = FALSE)+
  theme_light()
# SignalP
pb <- ggplot(data4, aes(y = DistToTE, x=SignalP, fill = SignalP, alpha = 1/10))+
  geom_jitter(show.legend = FALSE, shape = 16, position=position_jitter(0.4), size=2, color="grey") +
  geom_violin(show.legend = FALSE, color="black")+
  #facet_wrap(~species+secreted, ncol = 4)+
  scale_y_log10(breaks=c(1,10,100,1000,10000,100000,500000,1000000), labels=c("", "", "", "", "", "", "",""))+
  scale_x_discrete(limits = c("notSP", "SP"), labels=c("Non-SP", "SP"), position = "top") +
  ylab("") +
  xlab("") +
  scale_fill_manual(values = c("#999999","#56B4E9"), name = "")+
  # stat_summary give wrong mean
  #stat_summary(fun=mean, geom="point", color="grey2", show.legend = FALSE)+
  geom_point(aes(x=1, y=mean(data4$DistToTE[data4$SignalP=="notSP"])), colour="black", show.legend = FALSE) +
  geom_point(aes(x=2, y=mean(data4$DistToTE[data4$SignalP=="SP"])), colour="black", show.legend = FALSE) +
  annotation_logticks(sides = "rl")+
  theme(axis.line = element_line(colour = "black", size = 0.8, linetype = 1))+
  geom_signif(comparisons = list(c("notSP", "SP")), map_signif_level=TRUE, show.legend = FALSE)+
  theme_light()
# MS
pc <- ggplot(data4, aes(y = DistToTE, x=antiSMASH, fill = antiSMASH, alpha = 1/10))+
  geom_jitter(show.legend = FALSE, shape = 16, position=position_jitter(0.4), size=2, color="grey") +
  geom_violin(show.legend = FALSE, color="black")+
  #facet_wrap(~species+secreted, ncol = 4)+
  scale_y_log10(breaks=c(1,10,100,1000,10000,100000,500000,1000000), labels=c("1", "10", "100", "1,000", "10,000", "100,000", "500,000","1,000,000"), position = "right")+
  scale_x_discrete(limits = c("notMS", "MS"), labels=c("Non-SM", "SM"), position = "top") +
  ylab("") +
  xlab("") +
  scale_fill_manual(values = c("indianred", "#999999"), name = "")+
  # stat_summary give wrong mean
  #stat_summary(fun=mean, geom="point", color="grey2", show.legend = FALSE)+
  geom_point(aes(x=1, y=mean(data4$DistToTE[data4$antiSMASH=="notMS"])), colour="black", show.legend = FALSE) +
  geom_point(aes(x=2, y=mean(data4$DistToTE[data4$antiSMASH=="MS"])), colour="black", show.legend = FALSE) +
  annotation_logticks(sides = "rl")+
  theme(axis.line = element_line(colour = "black", size = 0.8, linetype = 1))+
  geom_signif(comparisons = list(c("notMS", "MS")), test = "wilcox.test", map_signif_level=TRUE, show.legend = FALSE)+
  theme_light()

multiplot(pa, pb, pc, cols = 3)
mean(data4$DistToTE[data4$EffectorP=="EFF"])
data_summary(data4$DistToTE[data4$EffectorP=="EFF"])
multiplot(pa, pb, pc, cols = 3)

## tests : 

t.test(data4$DistToTE[data4$EffectorP == "notEFF"], data4$DistToTE[data4$EffectorP == "EFF"])
t.test(data4$DistToTE[data4$SignalP == "notSP"], data4$DistToTE[data4$SignalP == "SP"])
t.test(data4$DistToTE[data4$antiSMASH == "notMS"], data4$DistToTE[data4$antiSMASH == "MS"])


## Divergence TEs families : 
data_gypsy <- read.csv('/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/13_Figures_finales/Divergence_TEs_plot/ESM015/GYPSY/GYPSY_moresensitive.coords', sep = '\t', header = F)
data_gypsy$typeTE <- "Gypsy invader"
data_RNATE <- read.csv('/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/13_Figures_finales/Divergence_TEs_plot/ESM015/RNA/0_Divergence_TEs_for_R_moresensitive.txt', sep = '\t', header = F)
data_RNATE$typeTE <- "RNA TEs"
data_Crypt1 <- read.csv('/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/13_Figures_finales/Divergence_TEs_plot/ESM015/Crypt1/Crypt1_moresensitive.coords', sep = '\t', header = F)
data_Crypt1$typeTE <- "Crypt1"
data_DNATE <- read.csv('/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/13_Figures_finales/Divergence_TEs_plot/ESM015/DNA/0_Divergence_TEs_for_R_moresensitive.txt', sep = '\t', header = F)
data_DNATE$typeTE <- "DNA TEs"

data <- rbind(data_RNATE, data_gypsy, data_Crypt1, data_DNATE)

colnames(data) <- c('start_ref','stop_ref','start_query', 'stop_query', 'len_ref', 'len_query', 'identity', 'tot_len_ref', 'tot_len_query', 'cov_ref', 'cov_query', 'ref_name', 'query_name', 'type_of_TE')
data$divergence <- 100 - as.numeric(data$identity)
ggplot(data,aes(x=divergence,weight=len_query, fill = type_of_TE))+ 
  geom_histogram(binwidth = 1) +
  scale_y_continuous(breaks=c(50000,100000,200000,300000,400000,500000,1000000), labels=c("50,000", "100,000", "200,000", "300,000", "400,000", "500,000", "1,000,000"))+
  #  theme_minimal()+
  scale_fill_brewer(palette="Paired") +
  xlab("Divergence (%)") +
  ylab("Cumulated length (bp)") +
  #ggtitle("Landscape plots of transposon divergence" ) +
  theme(axis.line = element_line(colour = "black", size = 0.8, linetype = 1)) +
  theme_light()

## GC CONTENT
data_GC <- read.csv('/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/13_Figures_finales/GC_content_AT_isochore/ESM015_3_GC_circa.csv', sep = '\t', header = F)
data_GC$type <- "ALL"
data_GC$portion <- (10000*100)/43305322
colnames(data_GC) <- c('chrom','start','GC', 'type', 'portion')
data_GC$GC_2digits <- format(data_GC$GC, "digits" = 3)
data_GC$GC_2digits <- as.numeric(data_GC$GC_2digits)


ggplot(data_GC,aes(x = GC_2digits, weight = portion),stat="count")+
  #facet_wrap(~type) +
  geom_histogram(fill = '#56B4E9', binwidth = 0.01)+
  #geom_density(fill="#FF6666") +
  #facet_wrap(~Species, scales = 'free_y')+
  theme(axis.line = element_line(colour = "black", size = 0.8, linetype = 1)) +
  #scale_x_continuous(breaks=c(0,25,50,75,100), labels=c("0", "25", "50", "75", "100"))+
  theme_light() +
  ylab(label = 'Portion of the genome (%)')+
  xlab(label = 'GC content (%)')

# Per length

data_GC <- read.csv('/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/13_Figures_finales/GC_content_AT_isochore/ESM015_3_GC_circa.csv', sep = '\t', header = F)
data_GC$type <- "ALL"
data_GC_Long <- read.csv('/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/13_Figures_finales/GC_content_AT_isochore/Long_scaff.csv', sep = '\t', header = F)
data_GC_Long$type <- "Long Scaffolds"
data_GC_Small <- read.csv('/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/13_Figures_finales/GC_content_AT_isochore/Small_scaff.csv', sep = '\t', header = F)
data_GC_Small$type <- "Small Scaffolds"
data_GC_Mito <- read.csv('/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/13_Figures_finales/GC_content_AT_isochore/Mito.csv', sep = '\t', header = F)
data_GC_Mito$type <- "Mitochondria"
data_GC <- rbind(data_GC, data_GC_Long, data_GC_Small, data_GC_Mito)
data_GC$portion <- (10000*100)/43305322
colnames(data_GC) <- c('chrom','start','GC', 'type', 'portion')
data_GC$GC_2digits <- format(data_GC$GC, "digits" = 3)
data_GC$GC_2digits <- as.numeric(data_GC$GC_2digits)


ggplot(data_GC,aes(x = GC_2digits, weight = portion),stat="count")+
  facet_wrap(~type) +
  geom_histogram(fill = '#56B4E9', binwidth = 0.01)+
  #geom_density(fill="#FF6666") +
  #facet_wrap(~Species, scales = 'free_y')+
  theme(axis.line = element_line(colour = "black", size = 0.8, linetype = 1)) +
  #scale_x_continuous(breaks=c(0,25,50,75,100), labels=c("0", "25", "50", "75", "100"))+
  theme_light() +
  ylab(label = 'Portion of the genome (%)')+
  xlab(label = 'GC content (%)')


## RIP Signatures
data_RIP <- read.csv('/home/arthur/Bureau/Article_Genome/Last_modif_Fev2021/RIP_rework_IC96/RIP_signatures_before/Home_made_method/NewHeader.RIP_signatures_v2.txt', sep = '\t', header = F)
data_RIP_EP155 <- read.csv('//home/arthur/Bureau/Article_Genome/Last_modif_Fev2021/RIP_rework_IC96/RIP_signatures_before/Home_made_method/EP155/NewHeader.RIP_signatures_v2.txt', sep = '\t', header = F)
colnames(data_RIP) <- c("TEname", "CpA", "TpG", "ApC", "GpT", "TpA", "ApT", "CpG", "GpC", "indice1", "indice2", "indice3", "typeTE")
colnames(data_RIP_EP155) <- c("TEname", "CpA", "TpG", "ApC", "GpT", "TpA", "ApT", "CpG", "GpC", "indice1", "indice2", "indice3", "typeTE")
data_RIP$typeTE <- as.factor(data_RIP$typeTE)
data_RIP$indice2 <- as.numeric(data_RIP$indice2)
data_RIP$indice1 <- as.numeric(data_RIP$indice1)
data_RIP_EP155$typeTE <- as.factor(data_RIP_EP155$typeTE)
data_RIP_EP155$indice2 <- as.numeric(data_RIP_EP155$indice2)
data_RIP_EP155$indice1 <- as.numeric(data_RIP_EP155$indice1)

# Confidence Interval 95% for baseline value :
Baseline_value_EP155 <- read.csv('/home/arthur/Bureau/Article_Genome/Last_modif_Fev2021/RIP_rework_IC96/RIP_signatures_rework/Cryphonectria_parasiticav2.nuclearAssembly.masked.singleline.RIP', sep = '\t', header = T)
Baseline_value_ESM015 <-read.csv('/home/arthur/Bureau/Article_Genome/Last_modif_Fev2021/RIP_rework_IC96/RIP_signatures_rework/FESM.masked.singleline.RIP', sep = '\t', header = T)

# IC 95% formula : 1.96 / sqrt(n_observations) * std

n_obs_value_EP155_CpA_TpG_ApC_GpT = sum(Baseline_value_EP155[4] != 'NaN')
n_obs_value_EP155_TpA_ApT = sum(Baseline_value_EP155[5] != 'NaN')
n_obs_value_EP155_CpG_GpC = sum(Baseline_value_EP155[6] != 'NaN')

n_obs_value_ESM015_CpA_TpG_ApC_GpT = sum(Baseline_value_ESM015[4] != 'NaN')
n_obs_value_ESM015_TpA_ApT = sum(Baseline_value_ESM015[5] != 'NaN')
n_obs_value_ESM015_CpG_GpC = sum(Baseline_value_ESM015[6] != 'NaN')

std_EP155_CpA_TpG_ApC_GpT = sd(Baseline_value_EP155[4] != 'NaN')
std_EP155_TpA_ApT = sd(Baseline_value_EP155[5] != 'NaN')
std_EP155_CpG_GpC = sd(Baseline_value_EP155[6] != 'NaN')

std_ESM015_CpA_TpG_ApC_GpT = sd(Baseline_value_ESM015[4] != 'NaN')
std_ESM015_TpA_ApT = sd(Baseline_value_ESM015[5] != 'NaN')
std_ESM015_CpG_GpC = sd(Baseline_value_ESM015[6] != 'NaN')

##CpG/GpC
# ESM015 :
p1 <- ggplot(data = subset(data_RIP, typeTE != "PotentialHostGene"), aes(x= typeTE , y=indice3, fill = typeTE))+
  geom_boxplot(show.legend = FALSE, fill = "firebrick3", alpha = 1/2)+
  #geom_point(aes(x= typeTE , y=indice1), colour = 'grey', alpha = 0.4)+
  #facet_wrap(~species , scales = 'fixed', ncol =6)+
  geom_hline(yintercept = 0.82, linetype="dashed", colour = 'red')+
 ## Following line for showing threshold in N. crassa
 # geom_hline(yintercept = 1.03, linetype="dashed", colour = 'blue', alpha = 0.5)+
  theme(axis.text.x = element_text(angle = 45, vjust = 1, size = 9, hjust = 1), plot.title = element_text(hjust=0.5)) +
  #  theme_minimal()+
  #ylab(label = '(CpA+TpG)/(ApC+GpT)')+
  ylab(label = '(CpG)/(GpC)')+
  xlab(label = '')+
  scale_y_continuous(limits = c(0,5), breaks=c(0,1,2,3,4,5), labels=c("0", "1", "2", "3", "4", "5"))+
  scale_fill_brewer(palette="Paired") +
  theme(axis.line = element_line(colour = "black", size = 0.8, linetype = 1)) +
  scale_x_discrete(labels=c("Crypt1", "DNA TEs", "Gypsy", "RNA TEs"), position = "bottom") +
  geom_rect(aes(xmin = 0, xmax = Inf, ymin = 0.82 - (3.291 / sqrt(n_obs_value_ESM015_CpG_GpC) * std_ESM015_CpG_GpC), ymax = 0.82 + (3.291 / sqrt(n_obs_value_ESM015_CpG_GpC) * std_ESM015_CpG_GpC)), alpha=0.2, fill="grey") +
  theme_light()
# EP155 :
p2 <- ggplot(data = subset(data_RIP_EP155, typeTE != "PotentialHostGene"), aes(x= typeTE , y=indice3, fill = typeTE))+
  geom_boxplot(show.legend = FALSE, fill = "dodgerblue3", alpha = 1/2)+
  #geom_point(aes(x= typeTE , y=indice3), colour = 'grey', alpha = 0.4)+
  #facet_wrap(~species , scales = 'fixed', ncol =6)+
  geom_hline(yintercept = 0.81, linetype="dashed", colour = 'red')+
  ## Following line for showing threshold in N. crassa
  #geom_hline(yintercept = 1.03, linetype="dashed", colour = 'blue', alpha = 0.5)+
  theme(axis.text.x = element_text(angle = 45, vjust = 1, size = 9, hjust = 1), plot.title = element_text(hjust=0.5)) +
  #  theme_minimal()+
  ylab(label = '')+
  xlab(label = '')+
  scale_y_continuous(limits = c(0,5), breaks=c(0,1,2,3,4,5), labels=c("0", "1", "2", "3", "4", "5"))+
  scale_fill_brewer(palette="Paired") +
  theme(axis.line = element_line(colour = "black", size = 0.8, linetype = 1)) +
  scale_x_discrete(labels=c("Crypt1", "DNA TEs", "Gypsy", "RNA TEs"), position = "bottom")+
  geom_rect(aes(xmin = 0, xmax = Inf, ymin = 0.81 - (3.291 / sqrt(n_obs_value_EP155_CpG_GpC) * std_EP155_CpG_GpC), ymax = 0.81 + (3.291 / sqrt(n_obs_value_EP155_CpG_GpC) * std_EP155_CpG_GpC)), alpha=0.2, fill="grey") +
  theme_light()


##(TpA)/(ApT)
# ESM015 :
p3 <- ggplot(data = subset(data_RIP, typeTE != "PotentialHostGene"), aes(x= typeTE , y=indice2, fill = typeTE))+
  geom_boxplot(show.legend = FALSE, fill = "firebrick3", alpha = 1/2)+
  #geom_point(aes(x= typeTE , y=indice2), colour = 'grey', alpha = 0.4)+
  #facet_wrap(~species , scales = 'fixed', ncol =6)+
  geom_hline(yintercept = 0.668 , linetype="dashed", colour = 'red')+
  ## Following line for showing threshold in N. crassa
  #geom_hline(yintercept = 0.89, linetype="dashed", colour = 'blue', alpha = 0.5)+
  theme(axis.text.x = element_text(angle = 45, vjust = 1, size = 9, hjust = 1), plot.title = element_text(hjust=0.5)) +
  #  theme_minimal()+
  scale_y_continuous(limits = c(0,5), breaks=c(0,1,2,3,4,5), labels=c("0", "1", "2", "3", "4", "5"))+
  ylab(label = '(TpA)/(ApT)')+
  xlab(label = '')+
  scale_fill_brewer(palette="Paired") +
  theme(axis.line = element_line(colour = "black", size = 0.8, linetype = 1)) +
  scale_x_discrete(labels=c("", "", "", ""))+
  geom_rect(aes(xmin = 0, xmax = Inf, ymin = 0.668 - (3.291 / sqrt(n_obs_value_ESM015_TpA_ApT) * std_ESM015_TpA_ApT), ymax = 0.668 + (3.291 / sqrt(n_obs_value_ESM015_TpA_ApT) * std_ESM015_TpA_ApT)), alpha=0.2, fill="grey") +
  theme_light()

# EP155 :
p4 <- ggplot(data = subset(data_RIP_EP155, typeTE != "PotentialHostGene"), aes(x= typeTE , y=indice2, fill = typeTE))+
  geom_boxplot(show.legend = FALSE, fill = "dodgerblue3", alpha = 1/2)+
  #geom_signif(comparisons = list(c("Gypsy_invader", "DNA_TEs")), 
  #            map_signif_level=TRUE)+
  #geom_point(aes(x= typeTE , y=indice2), colour = 'grey', alpha = 0.4)+
  #facet_wrap(~species , scales = 'fixed', ncol =6)+
  geom_hline(yintercept = 0.676 , linetype="dashed", colour = 'red')+
  ## Following line for showing threshold in N. crassa
  #geom_hline(yintercept = 0.89, linetype="dashed", colour = 'blue', alpha = 0.5)+
  theme(axis.text.x = element_text(angle = 45, vjust = 1, size = 9, hjust = 1), plot.title = element_text(hjust=0.5)) +
  #  theme_minimal()+
  scale_y_continuous(limits = c(0,5), breaks=c(0,1,2,3,4,5), labels=c("0", "1", "2", "3", "4", "5"))+
  ylab(label = '')+
  xlab(label = '')+
  theme(axis.line = element_line(colour = "black", size = 0.8, linetype = 1)) +
  scale_x_discrete(labels=c("", "", "", ""))+
  geom_rect(aes(xmin = 0, xmax = Inf, ymin = 0.676 - (3.291 / sqrt(n_obs_value_EP155_TpA_ApT) * std_EP155_TpA_ApT), ymax = 0.676 + (3.291 / sqrt(n_obs_value_EP155_TpA_ApT) * std_EP155_TpA_ApT)), alpha=0.2, fill="grey") +
  theme_light()

##(CpA+TpG)/(ApC+GpT)
# ESM015 :
p5 <- ggplot(data = subset(data_RIP, typeTE != "PotentialHostGene"), aes(x= typeTE , y=indice1, fill = typeTE))+
  geom_boxplot(show.legend = FALSE, fill = "firebrick3", alpha = 1/2)+
  #geom_point(aes(x= typeTE , y=indice1), colour = 'grey', alpha = 0.4)+
  #facet_wrap(~species , scales = 'fixed', ncol =6)+
  geom_hline(yintercept = 1.28, linetype="dashed", colour = 'red')+
  ## Following line for showing threshold in N. crassa
  # geom_hline(yintercept = 1.03, linetype="dashed", colour = 'blue', alpha = 0.5)+
  theme(axis.text.x = element_text(angle = 45, vjust = 1, size = 9, hjust = 1), plot.title = element_text(hjust=0.5)) +
  #  theme_minimal()+
  ylab(label = '(CpA+TpG)/(ApC+GpT)')+
  xlab(label = 'ESM015')+
  scale_y_continuous(limits = c(0,5), breaks=c(0,1,2,3,4,5), labels=c("0", "1", "2", "3", "4", "5"))+
  scale_fill_brewer(palette="Paired") +
  theme(axis.line = element_line(colour = "black", size = 0.8, linetype = 1)) +
  scale_x_discrete(labels=c("", "", "", ""), position = "top")+
  geom_rect(aes(xmin = 0, xmax = Inf, ymin = 1.28 - (3.291 / sqrt(n_obs_value_ESM015_CpA_TpG_ApC_GpT) * std_ESM015_CpA_TpG_ApC_GpT), ymax = 1.28 + (3.291 / sqrt(n_obs_value_ESM015_CpA_TpG_ApC_GpT) * std_ESM015_CpA_TpG_ApC_GpT)), alpha=0.2, fill="grey") +
  theme_light()
# EP155 :
p6 <- ggplot(data = subset(data_RIP_EP155, typeTE != "PotentialHostGene"), aes(x= typeTE , y=indice1, fill = typeTE))+
  geom_boxplot(show.legend = FALSE, fill = "dodgerblue3", alpha = 1/2)+
  #geom_point(aes(x= typeTE , y=indice3), colour = 'grey', alpha = 0.4)+
  #facet_wrap(~species , scales = 'fixed', ncol =6)+
  geom_hline(yintercept = 1.28, linetype="dashed", colour = 'red')+
  ## Following line for showing threshold in N. crassa
  #geom_hline(yintercept = 1.03, linetype="dashed", colour = 'blue', alpha = 0.5)+
  theme(axis.text.x = element_text(angle = 45, vjust = 1, size = 9, hjust = 1), plot.title = element_text(hjust=0.5)) +
  #  theme_minimal()+
  ylab(label = '')+
  xlab(label = 'EP155')+
  scale_y_continuous(limits = c(0,5), breaks=c(0,1,2,3,4,5), labels=c("0", "1", "2", "3", "4", "5"))+
  scale_fill_brewer(palette="Paired") +
  theme(axis.line = element_line(colour = "black", size = 0.8, linetype = 1)) +
  scale_x_discrete(labels=c("", "", "", ""), position = "top")+
  geom_rect(aes(xmin = 0, xmax = Inf, ymin = 1.28 - (3.291 / sqrt(n_obs_value_EP155_CpA_TpG_ApC_GpT) * std_EP155_CpA_TpG_ApC_GpT), ymax = 1.28 + (3.291 / sqrt(n_obs_value_EP155_CpA_TpG_ApC_GpT) * std_EP155_CpA_TpG_ApC_GpT)), alpha=0.2, fill="grey") +
  theme_light()

# Combine plots : 

# Multiple plot function
#
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.
#



multiplot(p5, p3, p1, p6, p4, p2, cols=2)

## tests : 

t.test(data_RIP_EP155$indice1[data_RIP_EP155$typeTE == "DNA_TEs"], data_RIP_EP155$indice1[data_RIP_EP155$typeTE == "RNA_TEs"])
t.test(data_RIP_EP155$indice1[data_RIP_EP155$typeTE == "DNA_TEs"], data_RIP_EP155$indice1[data_RIP_EP155$typeTE == "Gypsy_invader"])
t.test(data_RIP_EP155$indice1[data_RIP_EP155$typeTE == "Crypt1"], data_RIP_EP155$indice1[data_RIP_EP155$typeTE == "RNA_TEs"])
t.test(data_RIP_EP155$indice1[data_RIP_EP155$typeTE == "Crypt1"], data_RIP_EP155$indice1[data_RIP_EP155$typeTE == "Gypsy_invader"])


t.test(data_RIP$indice1[data_RIP$typeTE == "DNA_TEs"], data_RIP$indice1[data_RIP$typeTE == "RNA_TEs"])
t.test(data_RIP$indice1[data_RIP$typeTE == "DNA_TEs"], data_RIP$indice1[data_RIP$typeTE == "Gypsy_invader"])
t.test(data_RIP$indice1[data_RIP$typeTE == "Crypt1"], data_RIP$indice1[data_RIP$typeTE == "RNA_TEs"])
t.test(data_RIP$indice1[data_RIP$typeTE == "Crypt1"], data_RIP$indice1[data_RIP$typeTE == "Gypsy_invader"])



mean(data_RIP_EP155$indice1[data_RIP_EP155$typeTE == "DNA_TEs"], na.rm=TRUE)

mean(data_RIP$indice1[data_RIP$typeTE == "Crypt1"], na.rm=TRUE)



