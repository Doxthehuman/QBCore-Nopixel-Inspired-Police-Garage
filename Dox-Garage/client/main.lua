-- Dox Shop https://discord.gg/wQBuB3U5Ym
-- Dox Shop https://discord.gg/wQBuB3U5Ym
-- Dox Shop https://discord.gg/wQBuB3U5Ym
-- Dox Shop https://discord.gg/wQBuB3U5Ym

local PlayerData = {}
local pedspawned = false

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    	PlayerData =  QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
     	PlayerData.job = job
end)

RegisterNetEvent('QBCore:Player:SetPlayerData')
AddEventHandler('QBCore:Player:SetPlayerData', function(val)
	PlayerData = val
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k, v in pairs(Config.PedLocations) do
			local pos = GetEntityCoords(PlayerPedId())	
			local dist = #(v.coords - pos)
			
			if dist < 35 and not pedspawned then
				TriggerEvent('spawn:ped', v.coords)
				pedspawned = true
			elseif dist >= 35 and pedspawned then
				DeletePed(npc)
				pedspawned = false
			end
		end
	end
end)

RegisterNetEvent('spawn:ped')
AddEventHandler('spawn:ped',function(coords)
	local hash = `ig_trafficwarden`

	RequestModel(hash)
	while not HasModelLoaded(hash) do 
		Wait(10)
	end

    	pedspawned = true
	npc = CreatePed(5, hash, coords.x, coords.y, coords.z - 1.0, coords.w, false, false)
	FreezeEntityPosition(npc, true)
    	SetBlockingOfNonTemporaryEvents(npc, true)
	loadAnimDict("amb@world_human_cop_idles@male@idle_b") 
	TaskPlayAnim(npc, "amb@world_human_cop_idles@male@idle_b", "idle_e", 8.0, 1.0, -1, 17, 0, 0, 0, 0)
end)

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

RegisterNetEvent('dox:garage')
AddEventHandler('dox:garage', function(pd)
    local vehicle = pd.vehicle
    local coords = vector4(458.95, -993.23, 25.377454, 0)
    QBCore.Functions.SpawnVehicle(vehicle, function(veh)
        SetVehicleNumberPlateText(veh, "ZULU"..tostring(math.random(1000, 9999)))
        exports['LegacyFuel']:SetFuel(veh, 100.0)
        SetEntityHeading(veh, coords.w)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
        SetVehicleEngineOn(veh, true, true)
    end, coords, true)     
end)

RegisterNetEvent('dox:storecar')
AddEventHandler('dox:storecar', function()
    QBCore.Functions.Notify('Vehicle Stored!')
    local car = GetVehiclePedIsIn(PlayerPedId(),true)
    NetworkFadeOutEntity(car, true,false)
    Citizen.Wait(2000)
    QBCore.Functions.DeleteVehicle(car)
end)



RegisterNetEvent('garage:menu', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Police Garage",
            txt = ""
        },
        {
            id = 2,
            header = "Charger",
            txt = "Police Charger",
            params = {
                event = "dox:garage",
                args = {
                    vehicle = 'polchar',
                    
                }
            }
        },
        {
            id = 3,
            header = "Crown Vic",
            txt = "Police Crown Vic",
            params = {
                event = "dox:garage",
                args = {
                    vehicle = 'polvic',
                    
                }
            }
        },
        {
            id = 4,
            header = "Raptor",
            txt = "Police Raptor",
            params = {
                event = "dox:garage",
                args = {
                    vehicle = 'polraptor',
                    
                }
            }
        },
        {
            id = 5,
            header = "Taurus",
            txt = "Police Taurus",
            params = {
                event = "dox:garage",
                args = {
                    vehicle = 'poltaurus',
                    
                }
            }
        },
        {
            id = 6,
            header = "Mustang",
            txt = "Police Mustang",
            params = {
                event = "dox:garage",
                args = {
                    vehicle = '2015polstang',
                    
                }
            }
        },
        {
            id = 9,
            header = "Store Vehicle",
            txt = "Store Vehicle Inside Garage",
            params = {
                event = "dox:storecar",
                args = {
                    
                }
            }
        },
        
    })
end)
