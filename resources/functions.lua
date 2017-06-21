--[[
	## Library Scroll ##
	Designed By DevDavis (Davis Nuñez) 2011 - 2016.
	Based on library of Robert Galarga.
	Create a obj scroll, this is very usefull for list show
	]]
function newScroll(a,b,c)
	local obj = {ini=1,sel=1,lim=1,maxim=1,minim = 1}

	function obj:set(tab,mxn,modemintomin) -- Set a obj scroll
		obj.ini,obj.sel,obj.lim,obj.maxim,obj.minim = 1,1,1,1,1
		--os.message(tostring(type(tab)))
		if(type(tab)=="number")then
			if tab > mxn then obj.lim=mxn else obj.lim=tab end
			obj.maxim = tab
		else
			if #tab > mxn then obj.lim=mxn else obj.lim=#tab end
			obj.maxim = #tab
		end
		if modemintomin then obj.minim = obj.lim end
	end

	function obj:max(mx)
		obj.maxim = #mx
	end

	function obj:up()
		if obj.sel>obj.ini then obj.sel=obj.sel-1
		elseif obj.ini-1>=obj.minim then
			obj.ini,obj.sel,obj.lim=obj.ini-1,obj.sel-1,obj.lim-1
		end
	end

	function obj:down()
		if obj.sel<obj.lim then obj.sel=obj.sel+1
		elseif obj.lim+1<=obj.maxim then
			obj.ini,obj.sel,obj.lim=obj.ini+1,obj.sel+1,obj.lim+1
		end
	end

	if a and b then
		obj:set(a,b,c)
	end

	return obj

end



function create_f()                       ---Crear folder de trabajo
	files.mkdir(ACCOUNTF)
	files.copy(PAR,ACCOUNTF)
	files.copy(ICO,ACCOUNTF)
end	

function save_account()                   ---Guardar datos de cuenta
    buttons.homepopup(0)
    files.mkdir(ACCOUNTF+id)
    os.saveaccount(ACCOUNTF+id)
    files.copy(MISC,ACCOUNTF+id)
    os.message("\nThe account data has been saved",0) 
	buttons.homepopup(1)
end	

function restore_account()                ---Cambiar datos de cuenta
    buttons.homepopup(0)
    files.delete("ux0:/id.dat")
	os.restoreaccount(ACCOUNTF..list[scroll.sel].name)   
	files.copy(ACCOUNTF..list[scroll.sel].name.."/myprofile.dat","ur0:user/00/np/")
	os.message("We need to restart your PS Vita",0)
	os.delay(1500)
	buttons.homepopup(1)
	power.restart()
end	

function remove_account()                 ---Borramos datos de cuenta en la consola
	buttons.homepopup(0)
	os.removeaccount()
	files.delete(MISC)
	files.delete("ux0:id.dat")
	os.message("We need to restart your PS Vita",0)
	os.delay(1500)
	buttons.homepopup(1)
	power.restart()

end
