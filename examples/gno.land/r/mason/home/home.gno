package home

import (
	"gno.land/p/mason/md"
)

const (
	gnomeArt1 = `   /\
                  /  \
                  ,,,,,
                  (o.o)
                  (\_/)
                  -"-"-`
	dgnonut = `
                        #$$$$$$$$*                         
                     #$$@@@@@@@@@@$$$#                      
                   #$$@@@@@@@@@@@@@$$$$#                    
                 #$$$@@@@$$$$$$$$$$$$$$$$*                  
                #$$$$$$$$$$$$$$$$$$$$$$$$$#!                
               #$$$$$$$$$############$$$$$##*               
             !##$$$$$$####**********#####$###*              
            =##$$$$$###****!!!!!!!!!***######*!             
            *##$$$###***!!!!!!==!!!!!!**######*=            
           !*#######***!!!=;;;;;====!!!!**####**            
          !*#######**!!!==;;::::::;;==!!!**###**!           
          !*######***!==;::~~~~~~:::;;=!!!***#***=          
         =**#####**!!==;::~-,,,,,--~:;;=!!!******!          
         !**####***!==;:~-,..  ..,,-~:;==!!******!;         
        ;!**###***!!=;:~-,.       ..-~:;==!!*****!=         
        =!*******!!==::-.          .,-::==!!*****!=         
        =!*******!!=;:~,            .-~:;=!!!****!=:        
       ~=!*******!==;:-.            .,-:;=!!!****!=;        
       :=!*******!==;~,.             ,-:;==!!!***!=;        
       :=!******!!==:~,              ,-:;=!!!***!!=;        
       :=!!*****!!=;:~,              ,~:;=!!****!!=;-       
       :=!!!****!!==;~,              -~;==!!****!!=;-       
       :;=!!*****!!=;:-              -:;=!!*****!!=:-       
       ~;=!!!****!!==;~              :;=!!*****!!!;:-       
       ~;==!!****!!!==:              ;=!!******!!=;:,       
       ~:==!!!****!!!=;~            :=!********!!=;:.       
       -:;==!!*****!!!!;            =!*********!==;:        
       ,~;==!!*******!!==          =**#####****!==:~        
       ,~:;=!!!!*********!        **#######***!!=;~-        
        -~;;=!!!!**********!    *##$$$$$###***!!=:~.        
        ,~:;==!!!****##########$$$$$$$$###****!=;:~         
         -~:;==!!!***####$$$$$$@@@@@$$$###**!!=;:~,         
         ,-~:;=!!!***####$$$$@@@@@@$$$$##**!!!=;:-.         
          -~:;;=!!!***###$$$$$@@@@$$$$##***!!=;:-.          
          .-~:;;=!!!***###$$$$$$$$$$$##***!==;:~-           
           .-~:;==!!!!**####$$$$$$$###**!!==;:~-            
            ,-~::;==!!!!***########****!!==;:~-.            
             ,-~:;;==!!!!!***********!!!==;:~,.             
              ,,~~::;====!!!!!!!!!!!!!==;::~,.              
               .,-~::;;;===!!!!!!!!===;::~-,.               
                 ,--~~:;;;;========;;::~--.                 
                  .,,-~~:::::::::::~~~-,,.                  
                    ..,---~~~~~~~~~--,..                    
                       ..,,,,,,,,,...                       
                             ...`
)

func Render(path string) string {
	home := md.New()
	home.H1("Mason's Realm")

	home.Im("https://cdn.esawebb.org/archives/images/screen/weic2428a.jpg", "Placeholder")
	home.P("Welcome to my realm. " + md.Link("github", "https://github.com/masonmcbride"))

	home.H3("Dgnonut")
	home.Code(dgnonut)

	home.H3("More")
	home.Code(gnomeArt1)
	home.Bullet("Credit to " + md.Link("JJOptimist", "https://gno.land/r/jjoptimist/home") + " for this gnome art.")
	home.Bullet("I'm testing out my markdown system.")
	return home.Render()
}
