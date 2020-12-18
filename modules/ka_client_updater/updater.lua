_G.ClientUpdater = { }

local startTime = 0

function ClientUpdater.init()
    ClientUpdater.m = modules.ka_client_updater

    connect(g_updater, {
        onUpdateStart    = ClientUpdater.onUpdateStart,
        onUpdateProgress = ClientUpdater.onUpdateProgress,
        onUpdateEnd      = ClientUpdater.onUpdateEnd,
    })
end

function ClientUpdater.terminate()
    disconnect(g_updater, {
        onUpdateStart    = ClientUpdater.onUpdateStart,
        onUpdateProgress = ClientUpdater.onUpdateProgress,
        onUpdateEnd      = ClientUpdater.onUpdateEnd,
    })

    ClientUpdater.m = nil
end

function ClientUpdater.onUpdateStart()
    startTime = g_clock.millis()
end

function ClientUpdater.onUpdateProgress(receivedObj, totalObj, receivedBytes)
    local percent = (receivedObj/totalObj) * 100
    local deltaTime = (g_clock.millis() - startTime) / 1000
    local avgSpeed = receivedBytes / 1024 / deltaTime
    print(string.format("%d%% %.2f kB/s", percent, avgSpeed))
end

function ClientUpdater.onUpdateEnd()
    local callback = function()
        g_platform.spawnProcess("Kingdom Age Online.exe", { })
        exit()
    end
    displayOkCancelBox(tr("Info"), tr("Your client has been updated. Click OK to restart the client."), callback)
end
