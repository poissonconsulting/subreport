# sbr_tables md uses md files, sigfig_override and sigfig fallback

    Code
      cat(sbr_tables(md = TRUE, sigfig_override = c(coef2 = 2), pre_num = 0L))
    Message
      The following tables have no `.md` file and were formatted to 4 significant figures: 'fish/glance'
    Output
      
      #### Fish
      
      Table 1.
      
      | term | estimate |   sd |
      | :--- | -------: | ---: |
      | a | 0.53 | 0.16 |
      | b | 12.4&#8199; | 1.8&#8199; |
      
      Table 2.
      
      |term | estimate|   sd|
      |:----|--------:|----:|
      |a    |     0.53| 0.16|
      |b    |       12|  1.8|
      
      Table 3.
      
      |       y|
      |-------:|
      | 0.01586|

# sbr_tables md finds md files when sub is supplied

    Code
      cat(sbr_tables(sub = "a", md = TRUE, pre_num = 0L))
    Output
      
      Table 1.
      
      |      x |
      | -----: |
      | 1.500 |
      | 12.00&#8199; |
      
      #### B
      
      Table 2.
      
      |      x |
      | -----: |
      | 1.500 |
      | 12.00&#8199; |

