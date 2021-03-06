
plot_missing <- function(dataset, percent,xtickangle=0) {
  
  # Get Missing Patterns from Dataset.
  missing_patterns <- data.frame(is.na(dataset)) %>%
    group_by_all() %>%
    count(name = "Patterncount", sort = TRUE) %>%
    ungroup()
  
  # Set Column to Check for No Missing Pattern.
  missing_patterns$NoMissing <- apply(missing_patterns[1:ncol(missing_patterns)-1],1,any)
  
  # Create Dataset with Empty NA values 
  y <-  missing_patterns %>% 
    rownames_to_column("id") %>% 
    mutate(PatternPercentage = 100*Patterncount/sum(Patterncount)) %>% 
    pivot_longer(!c(id,Patterncount,PatternPercentage,NoMissing),names_to = "key",values_to = "value") %>% 
    merge(
      data.frame(colSums(is.na(dataset)))  %>% 
        rownames_to_column("key") %>% 
        rename(KeyCount = colSums.is.na.dataset.. ) %>% 
        mutate(KeyPercent = 100*KeyCount/sum(KeyCount)),  by="key")
  
  
  colnames(y) <- c("Key","PatternID","PatternCount","NoMissing","PatternPercentage","PatternValue","KeyCount","KeyPercentage")
  
  y$PatternID <- as.numeric(y$PatternID) %>% as.factor()
  
  # Find Graph Coordinates for Annotate
  Text_y_Cord <- missing_patterns %>% rownames_to_column("id") %>% filter(NoMissing == FALSE) %>% select(id)
  Text_y_Cord <- nrow(missing_patterns) + 1  - as.numeric(Text_y_Cord)
  Text_x_Cord <- (ncol(missing_patterns) - 2) / 2 + 0.5
  
  # Find Rect Coordinates for Annotate 
  Rect_x_Cord <- ncol(missing_patterns) - 2 + 0.5 
  
  # Tile Plot with Annotate 
  tile_plot <- ggplot(y, aes(x = fct_reorder(Key,desc(KeyCount)), y = fct_rev(PatternID), fill = PatternValue)) +
    geom_tile(color = "white",lwd = 1.5) + 
    scale_fill_brewer(palette = 'Purple' ) +
    ylab("Missing Pattern") +
    xlab("variable") + 
    annotate("text", x = Text_x_Cord,y = Text_y_Cord,alpha = 1.2,label="Complete Cases") +
    annotate("rect", xmin = 0.5, xmax = Rect_x_Cord, ymin = Text_y_Cord - 0.5 , ymax=Text_y_Cord + 0.5, alpha=0.1) + 
    theme(legend.position = "None" ,   axis.text.x = element_text(angle=xtickangle))
  
  
  
  # Row Count top plot
  if(percent){
    count_plot <- ggplot(y %>% distinct(Key,KeyPercentage)) +
      geom_bar(mapping = aes(x = fct_reorder(Key,desc(KeyPercentage)),y = KeyPercentage),stat = "identity",fill="#450d54") + 
      ggtitle("Missing value patterns") +
      ylab("% Rows Missing") + 
      xlab("") +
      theme_light() +
      theme (
        panel.grid.major.x = element_blank(),
        axis.text.x = element_text(angle=xtickangle)
      )
  } else {
    count_plot <- ggplot(y %>% distinct(Key,KeyCount)) +
      geom_bar(mapping = aes(x = fct_reorder(Key,desc(KeyCount)),y = KeyCount),stat = "identity",fill="#450d54") +
      ggtitle("Missing value patterns") +
      ylab("Num Rows Missing") + 
      xlab("") +
      theme_light() +
      theme (
        panel.grid.major.x = element_blank(),
        axis.text.x = element_text(angle=xtickangle)
      )
  }
  
  # Pattern Count right plot
  if(percent){
    patterncount_plot <- ggplot(y %>% distinct(PatternID,PatternPercentage,NoMissing)) +
      geom_bar(mapping = aes(x = fct_rev(PatternID),y = PatternPercentage,fill=NoMissing),stat = "identity") +
      scale_fill_brewer(palette = 'PuBuGn', direction= -1 ) +
      xlab("") +
      ylab("% of rows missing") + 
      coord_flip() +
      theme_light() +  
      theme(
        legend.position = "None",
        panel.grid.major.y = element_blank(),
        axis.text.x = element_text(angle=xtickangle)
        
      )
  } else {
    
    patterncount_plot <- ggplot(y %>% distinct(PatternID,PatternCount,NoMissing)) +
      geom_bar(mapping = aes(x = fct_rev(PatternID),y = PatternCount,fill=NoMissing),stat = "identity") +
      scale_fill_brewer(palette = 'PuBuGn', direction= -1 ) +
      xlab("") +
      ylab("row count") + 
      coord_flip() +
      theme_light() +  
      theme(
        legend.position = "None",
        panel.grid.major.y = element_blank(),
        axis.text.x = element_text(angle=xtickangle)
        
      )
  }
  
  # Patchwork , Set graphs in Position
  final_plot <- count_plot  + plot_spacer() + tile_plot + patterncount_plot + plot_layout(heights = c(1,3),widths = c(3,1))
  
  final_plot
  
}


missing_stacked_bar_plot <- function(dataset){
  dataset %>%
    summarise_all(list(~is.na(.)))%>%
    pivot_longer(everything(),
                 names_to = "variables", values_to="missing") %>%
    count(variables, missing) %>%
    ggplot(aes(y=variables,x=n,fill=missing))+
    geom_col(position = "fill")+
    labs(x="Proportion")+
    scale_fill_manual(values=c("#77d86b"))+
    theme(axis.title.y=element_blank())
}