----------Account Manager------------
splash.zoom("ux0:app/ACTMANGER/resources/back.png")
color.loadpalette()
back = image.load("resources/back.png")
buttonskey = image.load("resources/buttons.png",20,20)
PAR="ux0:app/ACTMANGER/resources/PARAM.SFO"
ICO="ux0:app/ACTMANGER/resources/ICON0.PNG"
id = ((os.login() or "")/"@")[1]
ACCOUNTF="ux0:pspemu/PSP/SAVEDATA/ACTM00001/"
MISC="ur0:user/00/np/myprofile.dat"

__NAMEVPK = "Account_Manager"
dofile("updater.lua")

dofile("resources/functions.lua")

-----------------Menu---------------------
list=nil

function get_list()
    list = files.listdirs(ACCOUNTF)
end

get_list()
scroll = newScroll(list,10)

if not files.exists(ACCOUNTF) then create_f() end    ---functions.lua

while true do
    buttons.read()
    if back then back:blit(0,0) end

    ---------------------------Impresion en pantalla-----------------------------------
    screen.print(480,10,"Account Manager",1,color.white,color.black,__ACENTER)

    if buttonskey then buttonskey:blitsprite(10,490,0) end
    screen.print(40,490,"To save Account Data",1,color.green,color.black)

    if buttonskey then buttonskey:blitsprite(920,490,2) end
    screen.print(910,490,"To change Account Data",1,color.yellow,color.black,__ARIGHT)

    if buttonskey then buttonskey:blitsprite(920,520,1) end
    screen.print(910,520,"To delete Account folder",1,color.yellow,color.black,__ARIGHT)

    if buttonskey then buttonskey:blitsprite(10,520,3) end
    screen.print(40,520,"To delete current account:",1,color.red,color.black)

    screen.print(315,520,id,1,color.yellow,color.black)

   ----------------------------------Controles de lista-------------------------------
    if list and #list > 0 then
        if buttons.up then scroll:up() end
        if buttons.down then scroll:down() end

        y=70
        for i=scroll.ini, scroll.lim do
            if i == scroll.sel then   draw.fillrect(10,y-3,940,25,color.new(255,0,0,100)) end
            screen.print(15,y,string.format("%02d",i)..". "..list[i].name,1,color.white,color.black)
            y+=26
        end 
    else
        screen.print(480,70,"you have no account data saved yet",1,color.yellow,color.black,__ACENTER)
    end

    if buttons.cross then                            ---Guardamos los datos de la cuenta existente
        if id == "" then
	        os.message("\nThere is no account data to be saved",0)
		else    
            if not files.exists(ACCOUNTF+id) then 
			    save_account()   ---functions.lua
                --Actualizamos lista
                get_list()
                scroll:set(list,10)
            else
                os.message("\nThe account data already exists!",0)
			end	
        end
    end

    if buttons.square then                           ---Cambiamos de cuenta ...hay q asegurarnos q hay algo en la lista
        if list and #list > 0 then
            if id != list[scroll.sel].name then 	
			    restore_account()      ---functions.lua
            else
                os.message("\nYou are on this account already",0)
            end
        else
            os.message("\nThere is no accounts to restore",0)
        end
    end

    if buttons.circle then                                ---Borramos cuenta existente
        if os.login() == "" then
            os.message("\nYou haven't login to any account yet",0)
        else
            if os.message("\nAre you sure you want to remove the current account?? \nIf you do so, this action can not be reversed!! ",1) == 1 then       
            remove_account()        ---functions.lua
            end
        end
    end

    if buttons.triangle then                               ---Borramos carpeta de datos de cuenta
        if list and #list > 0 then
            if os.message("\nYou really want to delete \n \n"+list[scroll.sel].name+"\n \nAccount folder??",1) == 1 then
            files.delete(ACCOUNTF..list[scroll.sel].name)
            get_list()
            scroll:set(list,10)
            end
        else
            os.message("\nThere is no account folders to delete",0)
        end
    end

    screen.flip()

end
