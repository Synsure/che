script_author = "Gorskin"  
script_name = "[GameFixer]" 
script_version = "3.1.1"
script_properties('work-in-pause')

local function print_error(result, str)
if not result then 
print('Failed to load '.. str ..' library')
end
end

local success, imgui = pcall(require, "mimgui")
print_error(success, 'mimgui')

local success, ffi = pcall(require, "ffi") 
print_error(success, 'ffi')
local cast = ffi.cast

local success, lfs = pcall(require, "lfs")
print_error(success, 'lfs')

local success, mimhot = pcall(require, "mimhot")
print_error(success, 'mimhot')

imgui.HotKey = mimhot.HotKey 

local success, rkeys = pcall(require, "rkeys")
 
print_error(success, 'rkeys')

local success, memory = pcall(require, "memory")
print_error(success, 'memory')

local success, encoding = pcall(require, "encoding")

print_error(success, 'encoding')

local success, wm = pcall(require, "windows.message")
print_error(success, 'windows.message')

local success, fa = pcall(require, "fAwesome5")
 
print_error(success, 'fAwesome5')

encoding.default = "ISO-8859-1"
local u8 = encoding.UTF8
local renderWindow, renderWindowTWS, new, str, sizeof = imgui.new.bool(), imgui.new.bool(), imgui.new, ffi.string, ffi.sizeof
local weaponSoundDelay = {[9] = 200, [37] = 900, } -- ugenrl
local soundsDir = "moonloader/gamefixer/genrl/" -- ugenrl
local sizeX, sizeY = getScreenResolution()

------------------------[ cfg ] -------------------
local inicfg = require("inicfg")
local directIni = "gamefixer.ini"
local ini = inicfg.load({
    settings = {
        openmenukeys = "[17,71]",
        theme = 6,
        nickdistance = 8,
        noradio = false,
        shownicks = false,
        showhp = false,
        showchat = false,
        showhud = false,
        bighpbar = false,
        weather = 1,
        hours = 17,
        min = 0,
        sync_time = false,
        gtatime = false,
        drawdist = 250.0,
        drawdistair = 1000.0,
        drawdistpara = 500.0,
        fog = 30.0,
        lod = 280.0,
        blockweather = true,
        blocktime = true,
        givemedist = true,
        targetblip = true,
        antiblockedplayer = true,
        chatt = true,
        unlimitfps = true,
        postfx = dtrue,
        nobirds = false,
        nocloudbig = false,
        nocloudsmall = false,
        nocloudhorizont = false,
        sensfix = true,
        sounds = true,
        intmusic = false,
        helptext = false,
        audiostream = false,
        fixblackroads = false,
        longarmfix = true,
        noshadows = true,
        pedshadows = true,
        maxshadows = true,
        poleshadows = true,
        vehshadows = true,
        waterfixquadro = true,
        intrun = true,
        shadowedit = true,
        mapzoom = true,
        mapzoomvalue = 280.0,
        shadowcp = 0,
        shadowlight = 0,
        animmoney = 2,
        fixcrosshair = true,
        crosshairX = 64,
        crosshairY = 64,
        noplaneline = true,
        sunfix = false,
        vsync = false,
        radarfix = false,
        radarWidth = 94,
        radarHeight = 76,
        radarPosX = 40,
        radarPosY = 104,
        fullmenuheight = 480.0,
        fullmenuwidth = 640.0,
        forceaniso = true,
        mapzoomfixer = true,
        fixloadmap = true,
        dual_monitor_fix = false,
        radar_color_fix = false,
        brightness = 128,
        nolimitmoneyhud = false,
        distobjects_stolb_fonars = 30.0,
        distobjects_musor = 10.0,
        tiretracks = true,
        moneyzerofix = false,
        givemedistobj = false,
        fullmenuimage = false,
        smalliconsradar = false,
        vehloddist = 200.0,
        handlingfix = true,
        nohealthflick = true,
        treepitching = false,
        fixbloodwood = true,
        fontmoneyborder = 1,
        lod_scale = 1.170,
        refreshratefix = true,
        osnov_icon = 7.0,
        quadro_icon_size = 1.4,
        quadro_icon_border = 1.4,
        trianglev_icon_size = 1.4,
        trianglev_icon_border = 1.4,
        trianglen_icon_size = 1.4,
        trianglen_icon_border = 1.4,
        player_icon_size = 8.0,
        recolorer = false,
        radrarnorth = false,
        anticrash = true,
    },
    effects_manager = {
        nosparks = false,
        nowaterfog = false,
        nogunfire = false,
        nogunsmoke = false,
        nofxsystem = false,
        noblood = false,
        noexhaust = false,
        wheelsand = false,
        wheeldust = false,
        wheelmud = false,
        wheelgravel = false,
        wheelgrass = false,
        wheelspray = false,
        nodust = false,
        gunshell = false,
        footprints = false,
        vehsparks = false,
        vehtaxilight = true,
        swim = false,
        vehdust = false,
        footdust = false,
        vehdmgdust = false,
        vehdmgsmoke = false,
        breakobject = false,
        nomorehaze = false,
    },
    nop_samp_keys = {
        key_F1 = false,
        key_F4 = false,
        key_F7 = false,
        key_T = false,
        key_ALTENTER = false,
    },
    smart_fps = {
        pedfps = 100,
        vehfps = 60,
        boatfps = 60,
        motofps = 60,
        bikefps = 60,
        swimfps = 22,
        helifps = 100,
        planefps = 100,
        snipergunfps = 90,
        spraygunfps = 30,
    },
    hphud = {
        status = true,
        fonts = 3,
        hptext = true,
        posX = 2,
        posY = 66,
    },
    cleaner = {
        autoclean = true,
        cleaninfo = true,
        limit = 500,
    },
    ugenrl_main = {
        enable = false,
        weapon = true,
        enemyWeapon = true,
        enemyWeaponDist = 70,
        hit = true,
        pain = true,
        informers = true,
        mode = 0,
    },
    ugenrl_volume = {
        weapon = 1.00,
        hit = 1.00,
        pain = 1.00,
        expl = 1.00,
    },
    custom_nametags = {
        status = false,
        fontName = "Times New Roman", -- Nombre de la fuente
        fontSize = 8, -- Tamaño de fuente
        fontFlag = 13,
    },
    ugenrl_sounds = {
        [22] = '9mm.mp3',
        [23] = 'Silecent-Pistol.mp3',
        [24] = 'Deagle1.wav',
        [25] = 'Shotgun.1.wav',
        [26] = 'Sawnoff-Shotgun.mp3',
        [27] = 'Combat-Shotgun.mp3',
        [28] = 'Uzi.mp3',
        [29] = 'MP5.mp3',
        [30] = 'AK.mp3',
        [31] = 'M4.1.wav',
        [32] = 'TEC-9.mp3',
        [33] = 'Rifle.mp3',
        [34] = 'Sniper.mp3',
        [35] = 'RPG.mp3',
        [36] = 'RPG.mp3',
        hit = 'Bell1.mp3',
        pain = 'Painmale1.mp3',
        expl = 'Explosion.mp3',
    },
    fixtimecyc = {
        active = false,
        allambient = 0.800,
        objambient = 0.800,
        worldambientR = 0.800,
        worldambientG = 0.800,
        worldambientB = 0.800,
    },
    commands = {
        openmenu = "/gmenu",
        settime = "/st",
        setweather = "/sw",
        blockservertime = "/bt",
        blockserverweather = "/bw",
        givemedist = "/givemedist",
        drawdistance = "/dd",
        drawdistanceair = "/ddair",
        drawdistancepara = "/ddpara",
        fogdistance = "/fd",
        loddistance = "/ld",
        fixtimecyc = "/fixtimecyc",
        offradio = "/gameradio",
        shownicks = "/sname",
        showhp = "/shp",
        showchat = "/showchat",
        showhud = "/showhud",
        bighpbar = "/160hp",
        fpslock = "/fpslock",
        postfx = "/postfx",
        antiblockedplayer = "/abplayer",
        animmoney = "/animmoney",
        chatopenfix = "/chatfix",
        autocleaner = "/accl",
        cleanmemory = "/ccl",
        cleaninfo = "/cclinfo",
        setmbforautocleaner = "/setccl",
        nobirds = "/nobirds",
        editcrosshair = "/ech",
        shadowedit = "/shadowedit",
        nocloudbig = "/nocloudbig",
        nocloudsmall = "/nocloudsmall",
        nocloudhorizont = "/nocloudhorizont",
        noshadows = "/noshadows",
        fixcrosshair = "/fixcrosshair",
        waterfixquadro = "/waterquadrofix",
        longarmfix = "/longarmfix",
        fixblackroads = "/fixblackroads",
        sensfix = "/sensfix",
        audiostream = "/audiostream",
        intmusic = "/intmusic",
        sounds = "/nosounds",
        noplaneline = "/noplaneline",
        sunfix = "/sunfix",
        targetblip = "/targetblip",
        vsync = "/vsync",
        radarfix = "/radarfix",
        radarWidth = "/radarw",
        radarHeight = "/radarh",
        radarx = "/radarx",
        radary = "/radary",
        ugenrl = "/ugenrl",
        uds = "/uds",
        uss = "/uss",
        ums = "/ums",
        urs = "/urs",
        uuzi = "/uuzi",
        ump5 = "/ump5",
        ubs = "/ubs",
        ups = "/ups",
        ugd = "/ugd",
        ugvw = "/ugvw",
        ugvh = "/ugvh",
        ugvp = "/ugvp",
        forceaniso = "/forceaniso",
        mapzoomfixer = "/mapzoomfixer",
        shadowcp = "/shadowcp",
        shadowlight = "/shadowlight",
        dual_monitor_fix = "/dualfix",
        radar_color_fix = "/radarcolorfix",
        aamb = "/aamb",
        oamb = "/oamb",
        wamb = "/wamb",
        brightness = "/brightness",
        nolimitmoneyhud = "/nolhud",
        tiretracks = "/tiretracks",
        tws = "/tws",
        ntgs = "/ntgs",
        moneyzerofix = "/mzfix",
        givemedistobj = "/givemedistobj",
        setfps = "/setfps",
        vehfps = "/vehfps",
        bikefps = "/bikefps",
        motofps = "/motofps",
        boatfps = "/boatfps",
        planefps = "/planefps",
        helifps = "/helifps",
        swimfps = "/swimfps",
        snipergunfps = "/sniperfps",
        spraygunfps = "/sprayfps"
    },
    --=======================[[Tema personalizado, configuración]]=====================
    PLeftUp = { r = 0.457, g = 0.311, b = 1, a = 1.00,},
    PLeftDown = { r = 0.459, g = 0.31, b = 1.00, a = 1.00, },
    PRightUp = { r = 0, g = 0, b = 0, a = 0, },
    PRightDown = { r = 0, g = 0, b = 0, a = 0, },
    WindowBG = { r = 0, g = 0, b = 0, a = 0.813, },
    ChildBG = { r = 0.06, g = 0.06, b = 0.06, a = 0.834, },
    ActiveText = { r = 0.538, g = 0.413, b = 1.00, a = 1.00, },
    PassiveText = { r = 0.728, g = 0.728, b = 0.728, a = 1.00, },
    ColorText = { r = 0.923, g = 0.923, b = 0.923, a = 1.00, },
    FrameBg = { r = 0.053, g = 0.08, b = 0.277, a = 1.00, },
    FrameBgHovered = { r = 0.304, g = 0.281, b = 0.945, a = 0.694, },
    FrameBgActive = { r = 0.398, g = 0.329, b = 0.953, a = 0.936, },
    CheckMark = { r = 0.502, g = 0.455, b = 1.00, a = 1.00, },
    SliderGrab = { r = 0.33, g = 0.33, b = 0.33, a = 1.00, },
    SliderGrabActive = { r = 0.347, g = 0.17, b = 1.00, a = 1.00, },
    Button = { r = 0.54, g = 0.396, b = 1.00, a = 1.00, },
    ButtonHovered = { r = 0.562, g = 0.281, b = 1.00, a = 0.635, },
    ButtonActive = { r = 0.386, g = 0.289, b = 1.00, a = 1.00, },
    Header = { r = 0.439, g = 0.264, b = 1.00, a = 1.00, },
    HeaderHovered = { r = 0.389, g = 0.332, b = 1.00, a = 0.477, },
    HeaderActive = { r = 0.376, g = 0.336, b = 1.00, a = 1.00, },
    ScrollbarBg = { r = 0.386, g = 0.268, b = 1.00, a = 0.635, },
    ScrollbarGrab = { r = 0.521, g = 0.349, b = 1.00, a = 1.00, },
    ScrollbarGrabHovered = { r = 0.434, g = 0.345, b = 1.00, a = 1.00, },
    ScrollbarGrabActive = { r = 0.441, g = 0.289, b = 1.00, a = 1.00, },
    logocolor = { r = 0.441, g = 0.289, b = 1.00, a = 1.00, },
    --=============================================================================
    --========================== [ recolorer ] ====================================
    RECOLORER_HEALTH = { r = 255, g = 2.3, b = 2.3, },
    RECOLORER_ARMOUR = { r = 214.8, g = 214.8, b = 214.8, },
    RECOLORER_PLAYERHEALTH = { r = 255, g = 0, b = 0, },
    RECOLORER_PLAYERHEALTH2 = { r = 50, g = 50, b = 50, },
    RECOLORER_PLAYERARMOR = { r = 1, g = 1, b = 1, },
    RECOLORER_PLAYERARMOR2 = { r = 0.50, g = 0.50, b = 0.50, },
    RECOLORER_MONEY = { r = 0, g = 129.8, b = 10.8, },
    RECOLORER_STARS = { r = 255, g = 189.3, b = 86.1, },
    RECOLORER_PATRONS = { r = 187.0, g = 210.0, b = 222.0, },
    --=============================================================================

}, directIni)
inicfg.save(ini, directIni)

local tLastKeys = {} -- Teclas de activación rápida

local ActOpenMenuKey = {
	v = decodeJson(ini.settings.openmenukeys)
}

function save()
    inicfg.save(ini, directIni)
end
-------------------------- [sliders] --------------------------
local sliders = {
    weather = new.int(ini.settings.weather),
    hours = new.int(ini.settings.hours),
    min = new.int(ini.settings.min),
    drawdist = new.float(ini.settings.drawdist),
    drawdistair = new.float(ini.settings.drawdistair),
    drawdistpara = new.float(ini.settings.drawdistpara),
    fog = new.float(ini.settings.fog),
    lod = new.float(ini.settings.lod),
    lod_scale = new.float(ini.settings.lod_scale),
    allambient = new.float(ini.fixtimecyc.allambient),
    objambient = new.float(ini.fixtimecyc.objambient),
    shadowcp = new.int(ini.settings.shadowcp),
    shadowlight = new.int(ini.settings.shadowlight),
    limitmem = new.int(ini.cleaner.limit),
    mapzoomvalue = new.float(ini.settings.mapzoomvalue),
    radarw = new.float(ini.settings.radarWidth),
    radarh = new.float(ini.settings.radarHeight),
    radarposx = new.int(ini.settings.radarPosX),
    radarposy = new.int(ini.settings.radarPosY),
    brightness = new.int(ini.settings.brightness),
    hpposX = new.float(ini.hphud.posX),
    hpposY = new.float(ini.hphud.posY),
    hpfonts = new.int(ini.hphud.fonts),
    distobjects_stolb_fonars = new.float(ini.settings.distobjects_stolb_fonars),
    distobjects_musor = new.float(ini.settings.distobjects_musor),
    nickdistance = new.float(ini.settings.nickdistance),
    custom_nametags_fontSize = new.int(ini.custom_nametags.fontSize),
    custom_nametags_fontFlag = new.int(ini.custom_nametags.fontFlag),
    vehloddist = new.float(ini.settings.vehloddist),

    osnov_icon = new.float(ini.settings.osnov_icon),
    quadro_icon_size = new.float(ini.settings.quadro_icon_size),
    quadro_icon_border = new.float(ini.settings.quadro_icon_border),
    trianglev_icon_size = new.float(ini.settings.trianglev_icon_size),
    trianglev_icon_border = new.float(ini.settings.trianglev_icon_border),
    trianglen_icon_size = new.float(ini.settings.trianglen_icon_size),
    trianglen_icon_border = new.float(ini.settings.trianglen_icon_border),
    player_icon_size = new.float(ini.settings.player_icon_size),


    ----------------------------------------------------------
    pedfps = new.int(ini.smart_fps.pedfps),
    vehfps = new.int(ini.smart_fps.vehfps),
    boatfps = new.int(ini.smart_fps.boatfps),
    motofps = new.int(ini.smart_fps.motofps),
    bikefps = new.int(ini.smart_fps.bikefps),
    swimfps = new.int(ini.smart_fps.swimfps),
    helifps = new.int(ini.smart_fps.helifps),
    planefps = new.int(ini.smart_fps.planefps),
    snipergunfps = new.int(ini.smart_fps.snipergunfps),
    spraygunfps = new.int(ini.smart_fps.spraygunfps),

    ---------------------------------------------------------



    ------------------------- [ugenrl] ---------------------------------
    weapon_volume_slider = new.float(ini.ugenrl_volume.weapon),
    hit_volume_slider = new.float(ini.ugenrl_volume.hit),
    pain_volume_slider = new.float(ini.ugenrl_volume.pain),
    expl_volume_slider = new.float(ini.ugenrl_volume.expl),
    enemyweapon_dist = new.int(ini.ugenrl_main.enemyWeaponDist),
    --------------------------------------------------------------------
}
--------------------------- [checkboxes] ---------------------------
local checkboxes = {
    anticrash = new.bool(ini.settings.anticrash),
    blockweather = new.bool(ini.settings.blockweather),
    blocktime = new.bool(ini.settings.blocktime),
    sync_time = new.bool(ini.settings.sync_time),
    gtatime = new.bool(ini.settings.gtatime),
    antiblockedplayer = new.bool(ini.settings.antiblockedplayer),
    chatt = new.bool(ini.settings.chatt),
    sensfix = new.bool(ini.settings.sensfix),
    fixblackroads = new.bool(ini.settings.fixblackroads),
    longarmfix = new.bool(ini.settings.longarmfix),
    waterfixquadro = new.bool(ini.settings.waterfixquadro),
    intrun = new.bool(ini.settings.intrun),
    cleaninfo = new.bool(ini.cleaner.cleaninfo),
    fixcrosshair = new.bool(ini.settings.fixcrosshair),
    mapzoom = new.bool(ini.settings.mapzoom),
    sunfix = new.bool(ini.settings.sunfix),
    radarfix = new.bool(ini.settings.radarfix),
    vehtaxilight = new.bool(ini.effects_manager.vehtaxilight),
    forceaniso = new.bool(ini.settings.forceaniso),
    mapzoomfixer = new.bool(ini.settings.mapzoomfixer),
    dual_monitor_fix = new.bool(ini.settings.dual_monitor_fix),
    radar_color_fix = new.bool(ini.settings.radar_color_fix),
    nop_samp_keys_F1 = new.bool(ini.nop_samp_keys.key_F1),
    nop_samp_keys_F4 = new.bool(ini.nop_samp_keys.key_F4),
    nop_samp_keys_F7 = new.bool(ini.nop_samp_keys.key_F7),
    nop_samp_keys_T = new.bool(ini.nop_samp_keys.key_T),
    nop_samp_keys_ALTENTER = new.bool(ini.nop_samp_keys.key_ALTENTER),
    nolimitmoneyhud = new.bool(ini.settings.nolimitmoneyhud),
    hphud = new.bool(ini.hphud.status),
    hpt = new.bool(ini.hphud.hptext),
    fixtimecyc = new.bool(ini.fixtimecyc.active),
    givemedist = new.bool(ini.settings.givemedist),
    shadowedit = new.bool(ini.settings.shadowedit),
    autoclean = new.bool(ini.cleaner.autoclean),
    vsync = new.bool(ini.settings.vsync),
    sounds = new.bool(ini.settings.sounds),
    noradio = new.bool(ini.settings.noradio),
    intmusic = new.bool(ini.settings.intmusic),
    audiostream = new.bool(ini.settings.audiostream),
    targetblip = new.bool(ini.settings.targetblip),
    fixloadmap = new.bool(ini.settings.fixloadmap),
    bighpbar = new.bool(ini.settings.bighpbar),
    helptext = new.bool(ini.settings.helptext),
    handlingfix = new.bool(ini.settings.handlingfix),
    treepitching = new.bool(ini.settings.treepitching),
    fixbloodwood = new.bool(ini.settings.fixbloodwood),
    refreshratefix = new.bool(ini.settings.refreshratefix),
    recolorer = new.bool(ini.settings.recolorer),
    ----------------- [ugenrl] ----------------------------
    ugenrl_enable = new.bool(ini.ugenrl_main.enable),
    weapon_checkbox = new.bool(ini.ugenrl_main.weapon),
    enemyweapon_checkbox = new.bool(ini.ugenrl_main.enemyWeapon),
    hit_checkbox = new.bool(ini.ugenrl_main.hit),
    pain_checkbox = new.bool(ini.ugenrl_main.pain),
    ---------------------------------------------------------
    showchat = new.bool(ini.settings.showchat),
    shownicks = new.bool(ini.settings.shownicks),
    showhp = new.bool(ini.settings.showhp),
    showhud = new.bool(ini.settings.showhud),
    unlimitfps = new.bool(ini.settings.unlimitfps),
    postfx = new.bool(ini.settings.postfx),
    nocloudsmall = new.bool(ini.settings.nocloudsmall),
    nocloudbig = new.bool(ini.settings.nocloudbig),
    nocloudhorizont = new.bool(ini.settings.nocloudhorizont),
    nobirds = new.bool(ini.settings.nobirds),
    noshadows = new.bool(ini.settings.noshadows),
    pedshadows = new.bool(ini.settings.pedshadows),
    vehshadows = new.bool(ini.settings.vehshadows),
    poleshadows = new.bool(ini.settings.poleshadows),
    maxshadows = new.bool(ini.settings.maxshadows),
    noplaneline = new.bool(ini.settings.noplaneline),
    tiretracks = new.bool(ini.settings.tiretracks),
    custom_nametags = new.bool(ini.custom_nametags.status),
    moneyzerofix = new.bool(ini.settings.moneyzerofix),
    givemedistobj = new.bool(ini.settings.givemedistobj),
    fullmenuimage = new.bool(ini.settings.fullmenuimage),
    smalliconsradar = new.bool(ini.settings.smalliconsradar),
    radrarnorth = new.bool(ini.settings.radrarnorth),
    nosparks = new.bool(ini.effects_manager.nosparks),
    nowaterfog = new.bool(ini.effects_manager.nowaterfog),
    nogunfire = new.bool(ini.effects_manager.nogunfire),
    nogunsmoke = new.bool(ini.effects_manager.nogunsmoke),
    nofxsystem = new.bool(ini.effects_manager.nofxsystem),
    noblood = new.bool(ini.effects_manager.noblood),
    noexhaust = new.bool(ini.effects_manager.noexhaust),
    wheelsand = new.bool(ini.effects_manager.wheelsand),
    wheeldust = new.bool(ini.effects_manager.wheeldust),
    wheelmud = new.bool(ini.effects_manager.wheelmud),
    wheelgravel = new.bool(ini.effects_manager.wheelgravel),
    wheelgrass = new.bool(ini.effects_manager.wheelgrass),
    wheelspray = new.bool(ini.effects_manager.wheelspray),
    vehsparks = new.bool(ini.effects_manager.vehsparks),
    nodust =  new.bool(ini.effects_manager.nodust),
    gunshell = new.bool(ini.effects_manager.gunshell),
    footprints = new.bool(ini.effects_manager.footprints),
    nohealthflick = new.bool(ini.settings.nohealthflick),
    swim = new.bool(ini.effects_manager.swim),
    vehdust = new.bool(ini.effects_manager.vehdust),
    vehdmgdust = new.bool(ini.effects_manager.vehdmgdust),
    footdust = new.bool(ini.effects_manager.footdust),
    vehdmgsmoke = new.bool(ini.effects_manager.vehdmgsmoke),
    breakobject = new.bool(ini.effects_manager.breakobject),
    nomorehaze = new.bool(ini.effects_manager.nomorehaze),

    timecyc_creator = new.bool(false),
}
------------------------- [BUFFER] ----------------------
local buffers = {
    search_cmd = new.char[64](),
    cnt_fontname = new.char[64](ini.custom_nametags.fontName),
    cmd_openmenu = new.char[64](ini.commands.openmenu),
    cmd_settime = new.char[64](ini.commands.settime),
    cmd_setweather = new.char[64](ini.commands.setweather),
    cmd_blockservertime = new.char[64](ini.commands.blockservertime),
    cmd_blockserverweather = new.char[64](ini.commands.blockserverweather),
    cmd_givemedist = new.char[64](ini.commands.givemedist),
    cmd_drawdistance = new.char[64](ini.commands.drawdistance),
    cmd_drawdistanceair = new.char[64](ini.commands.drawdistanceair),
    cmd_drawdistancepara = new.char[64](ini.commands.drawdistancepara),
    cmd_fogdistance = new.char[64](ini.commands.fogdistance),
    cmd_loddistance = new.char[64](ini.commands.loddistance),
    cmd_offradio = new.char[64](ini.commands.offradio),
    cmd_shownicks = new.char[64](ini.commands.shownicks),
    cmd_showhp = new.char[64](ini.commands.showhp),
    cmd_showchat = new.char[64](ini.commands.showchat),
    cmd_showhud = new.char[64](ini.commands.showhud),
    cmd_bighpbar = new.char[64](ini.commands.bighpbar),
    cmd_fpslock = new.char[64](ini.commands.fpslock),
    cmd_postfx = new.char[64](ini.commands.postfx),
    cmd_antiblockedplayer = new.char[64](ini.commands.antiblockedplayer),
    cmd_animmoney = new.char[64](ini.commands.animmoney),
    cmd_chatopenfix = new.char[64](ini.commands.chatopenfix),
    cmd_autocleaner = new.char[64](ini.commands.autocleaner),
    cmd_cleanmemory = new.char[64](ini.commands.cleanmemory),
    cmd_cleaninfo = new.char[64](ini.commands.cleaninfo),
    cmd_setmbforautocleaner = new.char[64](ini.commands.setmbforautocleaner),
    cmd_nobirds = new.char[64](ini.commands.nobirds),
    cmd_editcrosshair = new.char[64](ini.commands.editcrosshair),
    cmd_shadowedit = new.char[64](ini.commands.shadowedit),
    cmd_nocloudbig = new.char[64](ini.commands.nocloudbig),
    cmd_nocloudsmall = new.char[64](ini.commands.nocloudsmall),
    cmd_nocloudhorizont = new.char[64](ini.commands.nocloudhorizont),
    cmd_noshadows = new.char[64](ini.commands.noshadows),
    cmd_fixcrosshair = new.char[64](ini.commands.fixcrosshair),
    cmd_intrun = new.char[64](ini.commands.intrun),
    cmd_waterfixquadro = new.char[64](ini.commands.waterfixquadro),
    cmd_longarmfix = new.char[64](ini.commands.longarmfix),
    cmd_fixblackroads = new.char[64](ini.commands.fixblackroads),
    cmd_fixsens = new.char[64](ini.commands.sensfix),
    cmd_audiostream = new.char[64](ini.commands.audiostream),
    cmd_intmusic = new.char[64](ini.commands.intmusic),
    cmd_nosounds = new.char[64](ini.commands.sounds),
    cmd_noplaneline = new.char[64](ini.commands.noplaneline),
    cmd_sunfix = new.char[64](ini.commands.sunfix),
    cmd_targetblip = new.char[64](ini.commands.targetblip),
    vmenu_crx = new.int(ini.settings.crosshairX),
    vmenu_cry = new.int(ini.settings.crosshairY),
    fullmenuheight = new.float(ini.settings.fullmenuheight),
    fullmenuwidth = new.float(ini.settings.fullmenuwidth),
    cmd_vsync = new.char[64](ini.commands.vsync),
    cmd_radarfix = new.char[64](ini.commands.radarfix),
    cmd_radarwidth = new.char[64](ini.commands.radarWidth),
    cmd_radarheight = new.char[64](ini.commands.radarHeight),
    cmd_radarx = new.char[64](ini.commands.radarx),
    cmd_radary = new.char[64](ini.commands.radary),
    cmd_ugenrl = new.char[64](ini.commands.ugenrl),
    cmd_uds = new.char[64](ini.commands.uds),
    cmd_uss = new.char[64](ini.commands.uss),
    cmd_ums = new.char[64](ini.commands.ums),
    cmd_urs = new.char[64](ini.commands.urs),
    cmd_ubs = new.char[64](ini.commands.ubs),
    cmd_uuzi = new.char[64](ini.commands.uuzi),
    cmd_ump5 = new.char[64](ini.commands.ump5),
    cmd_ups = new.char[64](ini.commands.ups),
    cmd_ugd = new.char[64](ini.commands.ugd),
    cmd_ugvw = new.char[64](ini.commands.ugvw),
    cmd_ugvh = new.char[64](ini.commands.ugvh),
    cmd_ugvp = new.char[64](ini.commands.ugvp),
    cmd_forceaniso = new.char[64](ini.commands.forceaniso),
    cmd_mapzoomfixer = new.char[64](ini.commands.mapzoomfixer),
    cmd_shadowcp = new.char[64](ini.commands.shadowcp),
    cmd_shadowlight = new.char[64](ini.commands.shadowlight),
    cmd_dual_monitor_fix = new.char[64](ini.commands.dual_monitor_fix),
    cmd_radarfix = new.char[64](ini.commands.radarfix),
    cmd_radar_color_fix = new.char[64](ini.commands.radar_color_fix),
    cmd_brightness = new.char[64](ini.commands.brightness),
    cmd_nolimitmoneyhud = new.char[64](ini.commands.nolimitmoneyhud),
    cmd_tiretracks = new.char[64](ini.commands.tiretracks),
    cmd_tws = new.char[64](ini.commands.tws),
    cmd_fixtimecyc = new.char[64](ini.commands.fixtimecyc),
    cmd_aamb = new.char[64](ini.commands.aamb),
    cmd_oamb = new.char[64](ini.commands.oamb),
    cmd_wamb = new.char[64](ini.commands.wamb),
    cmd_ntgs = new.char[64](ini.commands.ntgs),
    cmd_moneyzerofix = new.char[64](ini.commands.moneyzerofix),
    cmd_givemedistobj = new.char[64](ini.commands.givemedistobj),
    cmd_setfps = new.char[64](ini.commands.setfps),
    cmd_vehfps = new.char[64](ini.commands.vehfps),
    cmd_bikefps = new.char[64](ini.commands.bikefps),
    cmd_motofps =  new.char[64](ini.commands.motofps),
    cmd_boatfps = new.char[64](ini.commands.boatfps),
    cmd_planefps = new.char[64](ini.commands.planefps),
    cmd_helifps = new.char[64](ini.commands.helifps),
    cmd_swimfps = new.char[64](ini.commands.swimfps),
    cmd_snipergunfps = new.char[64](ini.commands.snipergunfps),
    cmd_spraygunfps = new.char[64](ini.commands.spraygunfps),
    
}

local imguiInputsCmdEditor = {
    [u8"Abrir menú Gamefixer"] = {var = buffers.cmd_openmenu, cfg = "openmenu"},
    [u8"Abrir el menú para cambiar clima y hora"] = {var = buffers.cmd_tws, cfg = "tws"},
    [u8"cambio de hora"] = {var = buffers.cmd_settime, cfg = "settime"},
    [u8"cambiar el clima"] = {var = buffers.cmd_setweather, cfg = "setweather"},
    [u8"Bloquear el servidor para que no cambie la hora"] = {var = buffers.cmd_blockservertime, cfg = "blockservertime"},
    [u8"Bloquear el cambio de clima por el servidor"] = {var = buffers.cmd_blockserverweather, cfg = "blockserverweather"},
    [u8"Habilitar / deshabilitar la capacidad de cambiar la distancia de dibujo"] = {var = buffers.cmd_givemedist, cfg = "givemedist"},
    [u8"Cambiar la distancia de dibujo"] = {var = buffers.cmd_drawdistance, cfg = "drawdistance"},
    [u8"Cambiar la distancia de dibujo para el transporte aéreo"] = {var = buffers.cmd_drawdistanceair, cfg = "drawdistanceair"},
    [u8"Cambiar la distancia de dibujo al usar un paracaídas"] = {var = buffers.cmd_drawdistancepara, cfg = "drawdistancepara"},
    [u8"Cambiar rango de niebla"] = {var = buffers.cmd_fogdistance, cfg = "fogdistance"},
    [u8"Cambiar rango de lod"] = {var = buffers.cmd_loddistance, cfg = "loddistance"},
    [u8"Cambiar brillo"] = {var = buffers.cmd_brightness, cfg = "brightness"},
    [u8"Habilitar/Deshabilitar la radio en transporte"] = {var = buffers.cmd_offradio, cfg = "offradio"},
    [u8"Ocultar chat"] = {var = buffers.cmd_showchat, cfg = "showchat"},
    [u8"Ocultar HUD"] = {var = buffers.cmd_showhud, cfg = "showhud"},
    [u8"Mostrar/ocultar nombres de los jugadores"] = {var = buffers.cmd_shownicks, cfg = "shownicks"},
    [u8"Mostrar/Ocultar HP de lo jugadores"] = {var = buffers.cmd_showhp, cfg = "showhp"},
    [u8"Cambiar la velocidad de animación de cambiar la cantidad de dinero"] = {var = buffers.cmd_animmoney, cfg = "animmoney"},
    [u8"Activar/desactivar tira de 160hp"] = {var = buffers.cmd_bighpbar, cfg = "bighpbar"},
    [u8"Habilitar/deshabilitar el limitador de fps"] = {var = buffers.cmd_fpslock, cfg = "fpslock"},
    [u8"Habilitar/deshabilitar el posprocesamiento"] = {var = buffers.cmd_postfx, cfg = "postfx"},
    [u8"Habilitar / deshabilitar la solución para quedarse atascado en otros jugadores al generar"] = {var = buffers.cmd_antiblockedplayer, cfg = "antiblockedplayer"},
    [u8"Habilitar/Deshabilitar la apertura de chat en la tecla \"E\""] = {var = buffers.cmd_chatopenfix, cfg = "chatopenfix"},
    [u8"Habilitar / deshabilitar la memoria de borrado automático"] = {var = buffers.cmd_autocleaner, cfg = "autocleaner"},
    [u8"Limpiar memoria"] = {var = buffers.cmd_cleanmemory, cfg = "cleanmemory"},
    [u8"Habilitar / deshabilitar el mensaje sobre el borrado de la memoria"] = {var = buffers.cmd_cleaninfo, cfg = "cleaninfo"},
    [u8"Establecer un límite en megabytes para la memoria de limpieza automática"] = {var = buffers.cmd_setmbforautocleaner, cfg = "setmbforautocleaner"},
    [u8"Habilitar/deshabilitar pájaros"] = {var = buffers.cmd_nobirds, cfg = "nobirds"},
    [u8"Habilitar/deshabilitar corrección de ciclo de tiempo para nopostfx"] = {var = buffers.cmd_fixtimecyc, cfg = "fixtimecyc"},
    [u8"Cambiar iluminacion mundial"] = {var = buffers.cmd_aamb, cfg = "aamb"},
    [u8"Cambiar la iluminación de objetos y peds."] = {var = buffers.cmd_oamb, cfg = "oamb"},
    [u8"Cambiar el color del ciclo de tiempo en formato RGB"] = {var = buffers.cmd_wamb, cfg = "wamb"},
    [u8"Cambiar el tamaño de la mira"] = {var = buffers.cmd_editcrosshair, cfg = "editcrosshair"},
    [u8"Habilitar / deshabilitar la capacidad de cambiar las sombras"] = {var = buffers.cmd_shadowedit, cfg = "shadowedit"},
    [u8"Habilitar/Deshabilitar nubes altas"] = {var = buffers.cmd_nocloudbig, cfg = "nocloudbig"},
    [u8"Habilitar/Deshabilitar nubes bajas"] = {var = buffers.cmd_nocloudsmall, cfg = "nocloudsmall"},
    [u8"Habilitar/Deshabilitar nubes en el horizonte"] = {var = buffers.cmd_nocloudhorizont, cfg = "nocloudhorizont"},
    [u8"Habilitar/deshabilitar las sombras del juego"] = {var = buffers.cmd_noshadows, cfg = "noshadows"},
    [u8"Habilitar/deshabilitar la corrección de puntos blancos en el punto de mira"] = {var = buffers.cmd_fixcrosshair, cfg = "fixcrosshair"},
    [u8"Habilitar/deshabilitar corrección de agua cuadrada"] = {var = buffers.cmd_waterfixquadro, cfg = "waterfixquadro"},
    [u8"Habilitar/deshabilitar solución para brazos largos en vehículos de motor"] = {var = buffers.cmd_longarmfix, cfg = "longarmfix"},
    [u8"Habilitar/deshabilitar corrección de calles negras"] = {var = buffers.cmd_fixblackroads, cfg = "fixblackroads"},
    [u8"Habilitar/deshabilitar la corrección  de sensibilidad del mouse X e Y"] = {var = buffers.cmd_fixsens, cfg = "fixsens"},
    [u8"Activar/desactivar sonidos del servidor (audiostream)"] = {var = buffers.cmd_audiostream, cfg = "audiostream"},
    [u8"Eliminar el límite en la cantidad de dinero en el HUD"] = {var = buffers.cmd_nolimitmoneyhud, cfg = "nolimitmoneyhud"},
    [u8"Encender/apagar música en interiores"] = {var = buffers.cmd_intmusic, cfg = "intmusic"},
    [u8"Habilitar/deshabilitar los sonidos del juego"] = {var = buffers.cmd_nosounds, cfg = "nosounds"},
    [u8"Habilitar/Deshabilitar rayas de aviones en el cielo"] = {var = buffers.cmd_noplaneline, cfg = "noplaneline"},
    [u8"Encender/apagar el sol"] = {var = buffers.cmd_sunfix, cfg = "sunfix"},
    [u8"Habilitar/deshabilitar triángulo al apuntar un jugador"] = {var = buffers.cmd_targetblip, cfg = "targetblip"},
    [u8"Activar/Desactivar sincronización vertical"] = {var = buffers.cmd_vsync, cfg = "vsync"},
    [u8"Habilitar/deshabilitar corrección de color de trazo de radar"] = {var = buffers.cmd_radar_color_fix, cfg = "radar_color_fix"},
    [u8"Habilitar/deshabilitar editor de radar"] = {var = buffers.cmd_radarfix, cfg = "radarfix"},
    [u8"Habilitar/deshabilitar la salida fija del mouse al segundo monitor"] = {var = buffers.cmd_dual_monitor_fix, cfg = "dual_monitor_fix"},
    [u8"Cambiar la altura del radar"] = {var = buffers.cmd_radarwidth, cfg = "radarwidth"},
    [u8"Cambiar ancho de radar"] = {var = buffers.cmd_radarheight, cfg = "radarheight"},
    [u8"Cambiar la posición del radar X"] = {var = buffers.cmd_radarx, cfg = "radarx"},
    [u8"Cambiar la posición del radar Y"] = {var = buffers.cmd_radary, cfg = "radary"},
    [u8"Habilitar/deshabilitar Ultimate Genrl"] = {var = buffers.cmd_ugenrl, cfg = "ugenrl"},
    [u8"Cambiar sonido deagle"] = {var = buffers.cmd_uds, cfg = "uds"},
    [u8"Cambiar sonido shotgun"] = {var = buffers.cmd_uss, cfg = "uss"},
    [u8"Cambiar sonido m4"] = {var = buffers.cmd_ums, cfg = "ums"},
    [u8"Cambiar sonido rifle"] = {var = buffers.cmd_urs, cfg = "urs"},
    [u8"Cambiar sonido uzi"] = {var = buffers.cmd_uuzi, cfg = "uuzi"},
    [u8"Cambiar sonido mp5"] = {var = buffers.cmd_ump5, cfg = "ump5"},
    [u8"Cambiar sonido golpes"] = {var = buffers.cmd_ubs, cfg = "ubs"},
    [u8"Cambiar sonido dolor"] = {var = buffers.cmd_ups, cfg = "ups"},
    [u8"Cambiar la distancia de los sonidos de otros jugadores"] = {var = buffers.cmd_ugd, cfg = "ugd"},
    [u8"Cambiar el volumen del sonido de los disparos"] = {var = buffers.cmd_ugvw, cfg = "ugvw"},
    [u8"Cambiar el volumen del sonido de los hits"] = {var = buffers.cmd_ugvh, cfg = "ugvh"},
    [u8"Cambiar volumen de audio dolor"] = {var = buffers.cmd_ugvh, cfg = "ugvh"},
    [u8"Habilitar/deshabilitar el filtrado de texturas anisotrópicas"] = {var = buffers.cmd_forceaniso, cfg = "forceaniso"},
    [u8"Habilitar/deshabilitar la corrección de sensibilidad débil al hacer zoom en el mapa"] = {var = buffers.cmd_mapzoomfixer, cfg = "mapzoomfixer"},
    [u8"Cambiar sombras básicas"] = {var = buffers.cmd_shadowcp, cfg = "shadowcp"},
    [u8"Editar sombras de pilares"] = {var = buffers.cmd_shadowlight, cfg = "shadowlight"},
    [u8"Activar/Desactivar huellas de neumáticos"] = {var = buffers.cmd_tiretracks, cfg = "tiretracks"},
    [u8"Cambiar la distancia de dibujo de los nombres"] = {var = buffers.cmd_ntgs, cfg = "ntgs"},
    [u8"Correccion  del formato de visualizacion de dinero"] = {var = buffers.cmd_moneyzerofix, cfg = "moneyzerofix"},
    [u8"Habilitar / deshabilitar la capacidad de cambiar el rango de visibilidad de los objetos"] = {var = buffers.cmd_givemedistobj, cfg = "givemedistobj"},
    [u8"cambiar fps de pie"] = {var = buffers.cmd_setfps, cfg = "setfps"},
    [u8"cambiar fps en vehículos"] = {var = buffers.cmd_vehfps, cfg = "vehfps"},
    [u8"Cambiar fps en bici"] = {var = buffers.cmd_bikefps, cfg = "bikefps"},
    [u8"Cambiar fps en motos"] = {var = buffers.cmd_motofps, cfg = "motofps"},
    [u8"Cambiar fps en barcos"] = {var = buffers.cmd_boatfps, cfg = "boatfps"},
    [u8"Cambiar fps en aviones"] = {var = buffers.cmd_planefps, cfg = "planefps"},
    [u8"Cambiar fps en helicópteros"] = {var = buffers.cmd_helifps, cfg = "helifps"},
    [u8"Cambiar fps mientras nada"] = {var = buffers.cmd_swimfps, cfg = "swimfps"},
    [u8"Cambiar fps con sniper"] = {var = buffers.cmd_snipergunfps, cfg = "snipergunfps"},
    [u8"Cambiar fps con spray"] = {var = buffers.cmd_spraygunfps, cfg = "cmd_spraygunfps"},
}

local imguiCheckboxesFixesAndPatches = {
    [u8"Corrección al quedarse atascado en otros jugadores al generar"] = {var = checkboxes.antiblockedplayer, cfg = "antiblockedplayer", fnc = "_"},
    [u8"Abrir el chat en E (el bloqueo de teclas T no funciona para esta funcion)"] = {var = checkboxes.chatt, cfg = "chatt", fnc = "_"},
    [u8"Corrección de la sensibilidad del mouse a lo largo de los ejes X e Y"] = {var = checkboxes.sensfix, cfg = "sensfix", fnc = "FixSensitivity"},
    [u8"Corrección de caminos negros"] = {var = checkboxes.fixblackroads, cfg = "fixblackroads", fnc = "FixBlackRoads"},
    [u8"Corrección de brazo largo"] = {var = checkboxes.longarmfix, cfg = "longarmfix", fnc = "FixLongArm"},
    [u8"Corrección de agua cuadrado"] = {var = checkboxes.waterfixquadro, cfg = "waterfixquadro", fnc = "FixWaterQuadro"},
    [u8"Eliminar el limite de dinero en el HUD"] = {var = checkboxes.nolimitmoneyhud, cfg = "nolimitmoneyhud", fnc = "NoLimitMoneyHud"},
    [u8"Corrección del punto blanco en la mira"] = {var = checkboxes.fixcrosshair, cfg = "fixcrosshair", fnc = "FixCrosshair"},
    [u8"traer de vuelta el sol"] = {var = checkboxes.sunfix, cfg = "sunfix", fnc = "SunFix"},
    [u8"Corrección para salida del mouse al segundo monitor"] = {var = checkboxes.dual_monitor_fix, cfg = "dual_monitor_fix", fnc = "_"},
    [u8"Corrección de ondas en texturas [Filtrado anisotropico]"] = {var = checkboxes.forceaniso, cfg = "forceaniso", fnc = "ForceAniso"},
    [u8"Corrección de sensibilidad debil al hacer zoom en el mapa"] = {var = checkboxes.mapzoomfixer, cfg = "mapzoomfixer", fnc = "_"},
    [u8"Corrección de color de trazo de radar"] = {var = checkboxes.radar_color_fix, cfg = "radar_color_fix", fnc = "RadarColorFix"},
    [u8"Corrección de sacudidas de vehículos(Debe reiniciar GTA para que los cambios surtan efecto.)"] = {var = checkboxes.handlingfix, cfg = "handlingfix", fnc = "_"},
    [u8"Corrección para la carga de mapas largos en el menú ESC"] = {var = checkboxes.fixloadmap, cfg = "fixloadmap", fnc = "FixLoadMap"},
    [u8"Deshabilitar el balanceo del árbol en clima ventoso"] = {var = checkboxes.treepitching, cfg = "treepitching", fnc = "TreePitching"},
    [u8"Corrección de sangre cuando los árboles reciben daño"] = {var = checkboxes.fixbloodwood, cfg = "fixbloodwood", fnc = "FixBloodWood"},
    [u8"Corrección de Hertz (incluye soporte para 75 Hz y más para su monitor)"] = {var = checkboxes.refreshratefix, cfg = "refreshratefix", fnc = "_"},
    [u8"AntiCrash: elimina los límites de las advertencias de chat y también las oculta."] = {var = checkboxes.anticrash, cfg = "anticrash", fnc = "AntiCrash"},
}

local imguiCheckboxesBoostFPS = {
    [u8"Habilitar FPS unlock"] = {var = checkboxes.unlimitfps, cfg = "unlimitfps", fnc = "FPSUnlock"},
    [u8"Ocultar nombres de jugadores"] = {var = checkboxes.shownicks, cfg = "shownicks", fnc = "ShowNICKS"},
    [u8"Ocultar HP de lo jugadores"] = {var = checkboxes.showhp, cfg = "showhp", fnc = "ShowHP"},
}

local imguiCheckboxesEffectsManagerSky = {
    [u8"Desactivar nubes bajas"] = {var = checkboxes.nocloudsmall, cfg = "nocloudsmall", fnc = "NoCloudSmall"},
    [u8"Desactivar nubes altas"] = {var = checkboxes.nocloudbig, cfg = "nocloudbig", fnc = "NoCloudBig"},
    [u8"Desactivar nubes en el horizonte"] = {var = checkboxes.nocloudhorizont, cfg = "nocloudhorizont", fnc = "NoCloudHorizont"},
    [u8"Desactivar los pájaros"] = {var = checkboxes.nobirds, cfg = "nobirds", fnc = "NoBirds"},
}

local imguiCheckboxesEffectsManagerOther = {
    [u8"Desactivar el posprocesamiento"] = {var = checkboxes.postfx, cfg = "postfx", fnc = "NoPostfx"},
    [u8"Desactivar el humo de tubería en edificios."] = {var = checkboxes.nofxsystem, cfg = "nofxsystem", fnc = "EffectsManager"},
    [u8"Desactivar efecto de sangre"] = {var = checkboxes.noblood, cfg = "noblood", fnc = "EffectsManager"},
    [u8"Desactivar huellas en la arena."] = {var = checkboxes.footprints, cfg = "footprints", fnc = "EffectsManager"},
    [u8"Desactivar efectos de agua"] = {var = checkboxes.swim, cfg = "swim", fnc = "EffectsManager"},
    [u8"Desactivar la niebla sobre el agua"] = {var = checkboxes.nowaterfog, cfg = "nowaterfog", fnc = "EffectsManager"},
    [u8"Desactivar el polvo al caminar"] = {var = checkboxes.footdust, cfg = "footdust", fnc = "EffectsManager"},
    [u8"Desactivar el polvo cuando los objetos se dañan"] = {var = checkboxes.breakobject, cfg = "breakobject", fnc = "EffectsManager"},
    [u8"Desactivar efecto de calor"] = {var = checkboxes.nomorehaze, cfg = "nomorehaze", fnc = "EffectsManager"},
}

local imguiCheckboxesVehicleEffectsManager = {
    [u8"Desactivar la arena/polvo debajo de las ruedas."] = {var = checkboxes.wheelsand, cfg = "wheelsand", fnc = "EffectsManager"},
    [u8"Desactivar el polvo conduciendo en zonas verdes."] = {var = checkboxes.wheeldust, cfg = "wheeldust", fnc = "EffectsManager"},
    [u8"Desactivar el polvo de suciedad de las ruedas."] = {var = checkboxes.wheelmud, cfg = "wheelmud", fnc = "EffectsManager"},
    [u8"Desactivar la grava de debajo de las ruedas."] = {var = checkboxes.wheelgravel, cfg = "wheelgravel", fnc = "EffectsManager"},
    [u8"Desactivar la hierba de debajo de las ruedas."] = {var = checkboxes.wheelgrass, cfg = "wheelgrass", fnc = "EffectsManager"},
    [u8"Desactivar el humo debajo de las ruedas."] = {var = checkboxes.wheelspray, cfg = "wheelspray", fnc = "EffectsManager"},
    [u8"Desactivar chispas al chocar."] = {var = checkboxes.vehsparks, cfg = "vehsparks", fnc = "EffectsManager"},
    [u8"Desactivar huellas de neumáticos."] = {var = checkboxes.tiretracks, cfg = "tiretracks", fnc = "NoTireTracks"},
    [u8"Desactivar el humo del tubo de escape."] = {var = checkboxes.noexhaust, cfg = "noexhaust", fnc = "EffectsManager"},
    [u8"Desactivar las rayas de los aviones en el cielo."] = {var = checkboxes.noplaneline, cfg = "noplaneline", fnc = "NoPlaneLine"},
    [u8"Desactivar el brillo de las fichas de taxi."] = {var = checkboxes.vehtaxilight, cfg = "vehtaxilight", fnc = "EffectsManager"},
    [u8"Desactivar el polvo del transporte aéreo."] = {var = checkboxes.vehdust, cfg = "vehdust", fnc = "EffectsManager"},
    [u8"Desactivar polvo en colisión."] = {var = checkboxes.vehdmgdust, cfg = "vehdmgdust", fnc = "EffectsManager"},
    [u8"Desactivar el humo de los vehículos dañados."] = {var = checkboxes.vehdmgsmoke, cfg = "vehdmgsmoke", fnc = "EffectsManager"},
}

local imguiCheckboxesWeaponEffectsManager = {
    [u8"Desactivar chispas al disparar el suelo/paredes"] = {var = checkboxes.nosparks, cfg = "nosparks", fnc = "EffectsManager"},
    [u8"Desactivar fuego del arma"] = {var = checkboxes.nogunfire, cfg = "nogunfire", fnc = "EffectsManager"},
    [u8"Desactivar el humo de las armas."] = {var = checkboxes.nogunsmoke, cfg = "nogunsmoke", fnc = "EffectsManager"},
    [u8"Desactive el polvo al disparar al suelo, arena"] = {var = checkboxes.nodust, cfg = "nodust", fnc = "EffectsManager"},
    [u8"Desactivar casquillos de balas"] = {var = checkboxes.gunshell, cfg = "gunshell", fnc = "EffectsManager"},
}

local icolors = {
    wamb = new.float[3](ini.fixtimecyc.worldambientR, ini.fixtimecyc.worldambientG, ini.fixtimecyc.worldambientB),
    PLeftUp = new.float[4](ini.PLeftUp.r, ini.PLeftUp.g, ini.PLeftUp.b, ini.PLeftUp.a),
    PLeftDown = new.float[4](ini.PLeftDown.r, ini.PLeftDown.g, ini.PLeftDown.b, ini.PLeftDown.a),
    PRightUp = new.float[4](ini.PRightUp.r, ini.PRightUp.g, ini.PRightUp.b, ini.PRightUp.a),
    PRightDown = new.float[4](ini.PRightDown.r, ini.PRightDown.g, ini.PRightDown.b, ini.PRightDown.a),
    WindowBG = new.float[4](ini.WindowBG.r, ini.WindowBG.g, ini.WindowBG.b, ini.WindowBG.a),
    ChildBG = new.float[4](ini.ChildBG.r, ini.ChildBG.g, ini.ChildBG.b, ini.ChildBG.a),
    ActiveText = new.float[4](ini.ActiveText.r, ini.ActiveText.g, ini.ActiveText.b, ini.ActiveText.a),
    PassiveText = new.float[4](ini.PassiveText.r, ini.PassiveText.g, ini.PassiveText.b, ini.PassiveText.a),
    ColorText = new.float[4](ini.ColorText.r, ini.ColorText.g, ini.ColorText.b, ini.ColorText.a),
    FrameBg = new.float[4](ini.FrameBg.r, ini.FrameBg.g, ini.FrameBg.b, ini.FrameBg.a),
    FrameBgHovered = new.float[4](ini.FrameBgHovered.r, ini.FrameBgHovered.g, ini.FrameBgHovered.b, ini.FrameBgHovered.a),
    FrameBgActive = new.float[4](ini.FrameBgActive.r, ini.FrameBgActive.g, ini.FrameBgActive.b, ini.FrameBgActive.a),
    CheckMark = new.float[4](ini.CheckMark.r, ini.CheckMark.g, ini.CheckMark.b, ini.CheckMark.a),
    SliderGrab = new.float[4](ini.SliderGrab.r, ini.SliderGrab.g, ini.SliderGrab.b, ini.SliderGrab.a),
    SliderGrabActive = new.float[4](ini.SliderGrabActive.r, ini.SliderGrabActive.g, ini.SliderGrabActive.b, ini.SliderGrabActive.a),
    Button = new.float[4](ini.Button.r, ini.Button.g, ini.Button.b, ini.Button.a),
    ButtonHovered = new.float[4](ini.ButtonHovered.r, ini.ButtonHovered.g, ini.ButtonHovered.b, ini.ButtonHovered.a),
    ButtonActive = new.float[4](ini.ButtonActive.r, ini.ButtonActive.g, ini.ButtonActive.b, ini.ButtonActive.a),
    Header = new.float[4](ini.Header.r, ini.Header.g, ini.Header.b, ini.Header.a),
    HeaderHovered = new.float[4](ini.HeaderHovered.r, ini.HeaderHovered.g, ini.HeaderHovered.b, ini.HeaderHovered.a),
    HeaderActive = new.float[4](ini.HeaderActive.r, ini.HeaderActive.g, ini.HeaderActive.b, ini.HeaderActive.a),
    ScrollbarBg = new.float[4](ini.ScrollbarBg.r, ini.ScrollbarBg.g, ini.ScrollbarBg.b, ini.ScrollbarBg.a),
    ScrollbarGrab = new.float[4](ini.ScrollbarGrab.r, ini.ScrollbarGrab.g, ini.ScrollbarGrab.b, ini.ScrollbarGrab.a),
    ScrollbarGrabHovered = new.float[4](ini.ScrollbarGrabHovered.r, ini.ScrollbarGrabHovered.g, ini.ScrollbarGrabHovered.b, ini.ScrollbarGrabHovered.a),
    ScrollbarGrabActive = new.float[4](ini.ScrollbarGrabActive.r, ini.ScrollbarGrabActive.g, ini.ScrollbarGrabActive.b, ini.ScrollbarGrabActive.a),
    LogoColor = new.float[4](ini.logocolor.r, ini.logocolor.g, ini.logocolor.b, ini.logocolor.a),

    --------------------------------------------
    RECOLORER_HEALTH = new.float[3](ini.RECOLORER_HEALTH.r, ini.RECOLORER_HEALTH.g, ini.RECOLORER_HEALTH.b),
    RECOLORER_ARMOUR = new.float[3](ini.RECOLORER_ARMOUR.r, ini.RECOLORER_ARMOUR.g, ini.RECOLORER_ARMOUR.b),
    RECOLORER_PLAYERHEALTH = new.float[3](ini.RECOLORER_PLAYERHEALTH.r, ini.RECOLORER_PLAYERHEALTH.g, ini.RECOLORER_PLAYERHEALTH.b),
    RECOLORER_PLAYERHEALTH2 = new.float[3](ini.RECOLORER_PLAYERHEALTH2.r, ini.RECOLORER_PLAYERHEALTH2.g, ini.RECOLORER_PLAYERHEALTH2.b),
    RECOLORER_PLAYERARMOR = new.float[3](ini.RECOLORER_PLAYERARMOR.r, ini.RECOLORER_PLAYERARMOR.g, ini.RECOLORER_PLAYERARMOR.b),
    RECOLORER_PLAYERARMOR2 = new.float[3](ini.RECOLORER_PLAYERARMOR2.r, ini.RECOLORER_PLAYERARMOR2.g, ini.RECOLORER_PLAYERARMOR2.b),
    RECOLORER_MONEY = new.float[3](ini.RECOLORER_MONEY.r, ini.RECOLORER_MONEY.g, ini.RECOLORER_MONEY.b),
    RECOLORER_STARS = new.float[3](ini.RECOLORER_STARS.r, ini.RECOLORER_STARS.g, ini.RECOLORER_STARS.b),
    RECOLORER_PATRONS = new.float[3](ini.RECOLORER_PATRONS.r, ini.RECOLORER_PATRONS.g, ini.RECOLORER_PATRONS.b),
}

local crx, cry = ffi.new('float[1]'), ffi.new('float[1]')

local tbStyle = {
    u8"tema propio",
    u8"Rojo",
    u8"marrón",
    u8"Agua",
    u8"Negro",
    u8"púrpura",
    u8"negro y naranja",
    u8"Gris",
    u8"Cereza",
    u8"Verde",
    u8"Púrpura",
    u8"verde oscuro",
    u8"naranja",
    u8"Azul",
}

local tStyle = imgui.new['const char*'][#tbStyle](tbStyle)
local iStyle = new.int(ini.settings.theme-1)

local tbmtext = {
    u8"Rápido",
    u8"Sin animación",
    u8"Estándar",
}

local tmtext = imgui.new['const char*'][#tbmtext](tbmtext)
local ivar = new.int(ini.settings.animmoney)


local gmodetext = {
    u8"Alto rendimiento",
    u8"Sonidos del juego + Genrl",
    u8"Sonidos del juego + campana",
}

local gmodechar = imgui.new['const char*'][#gmodetext](gmodetext)
local gmodevar = new.int(ini.ugenrl_main.mode)

local fontmoneybordertext = {
    u8"sin trazo",
    u8"Delgado",
    u8"Estándar",
}

local fontmoneyborderchar = imgui.new['const char*'][#fontmoneybordertext](fontmoneybordertext)
local fontmoneybordervar = new.int(ini.settings.fontmoneyborder)

local getBonePosition = ffi.cast("int (__thiscall*)(void*, float*, int, bool)", 0x5E4280)


-------------------
function __genOrderedIndex( t )
    local orderedIndex = {}
    for key in pairs(t) do
        table.insert( orderedIndex, key )
    end
    table.sort( orderedIndex )
    return orderedIndex
end

function orderedNext(t, state)
    local key = nil
    if state == nil then
        t.__orderedIndex = __genOrderedIndex( t )
        key = t.__orderedIndex[1]
    else
        for i = 1,table.getn(t.__orderedIndex) do
            if t.__orderedIndex[i] == state then
                key = t.__orderedIndex[i+1]
            end
        end
    end
    if key then
        return key, t[key]
    end
    t.__orderedIndex = nil
    return
end
function orderedPairs(t)
    return orderedNext, t, nil
end
------------------

local ui_meta = {
    __index = function(self, v)
        if v == "switch" then
            local switch = function()
                if self.process and self.process:status() ~= "dead" then
                    return false -- // ¡La animación anterior no se completará!
                end
                self.timer = os.clock()
                self.state = not self.state

                self.process = lua_thread.create(function()
                    local bringFloatTo = function(from, to, start_time, duration)
                        local timer = os.clock() - start_time
                        if timer >= 0.00 and timer <= duration then
                            local count = timer / (duration / 100)
                            return count * ((to - from) / 100)
                        end
                        return (timer > duration) and to or from
                    end

                    while true do wait(0)
                        local a = bringFloatTo(0.00, 1.00, self.timer, self.duration)
                        self.alpha = self.state and a or 1.00 - a
                        if a == 1.00 then break end
                    end
                end)
                return true -- // ¡El estado de la ventana cambió!
            end
            return switch
        end
 
        if v == "alpha" then
            return self.state and 1.00 or 0.00
        end
    end
}

local gfmenu = { state = false, duration = 0.4555 }
setmetatable(gfmenu, ui_meta)

local twsmenu = { state = false, duration = 0.4555 }
setmetatable(twsmenu, ui_meta)

function LoadPatch()
    writeMemory(0x5B8E55, 4, 0x15F90, true)--flickr
    writeMemory(0x5B8EB0, 4, 0x15F90, true)--flickr
    memory.setfloat(0xB5FCC8, 0.45, true)--AudioFix, fixes a bug due to which the sounds of the audio stream were not heard if the user had the radio turned off in the game settings and after changing the sound settings there was still no sound, it was necessary to re-enter the game.
    writeMemory(0x5EFFE7, 1, 0xEB, true)-- disable talking
    memory.fill(0x5557CF, 0x90, 7, true) -- binthesky by DK
    writeMemory(0x53E94C, 1, 1, true) --del fps delay 14 ms
    writeMemory(0x745BC9, 2, 0x9090, true) --SADisplayResolutions(1920x1080// 16:9)
    memory.write(12761548, 1051965045, 4, true) --car speed fps fix
    memory.fill(0x555854, 0x90, 5, true) --InterioRreflections
    memory.fill(0x47C8CA, 0x90, 5, true) -- fix cj bug
end

function onSystemInitialized()
    LoadPatch()
    if ini.settings.handlingfix and doesFileExist(getGameDirectory().."/data/handling.txt") then
        memory.copy(0x86A964, memory.strptr('handling.txt'), 16, true)
    end
end

--====================================== | Timecyc Editor | ============================
local weather = {
	[0]  = u8"EXTRASUNNY_LA",
	[1]  = u8"SUNNY_LA",
	[2]  = u8"EXTRASUNNY_SMOG_LA",
	[3]  = u8"SUNNY_SMOG_LA",
	[4]  = u8"CLOUDY_LA",
	[5]  = u8"SUNNY_SF",
	[6]  = u8"EXTRASUNNY_SF",
	[7]  = u8"CLOUDY_SF",
	[8]  = u8"RAINY_SF",
	[9]  = u8"FOGGY_SF",
	[10] = u8"SUNNY_VEGAS",
	[11] = u8"EXTRASUNNY_VEGAS",
	[12] = u8"CLOUDY_VEGAS",
	[13] = u8"EXTRASUNNY_COUNTRYSIDE",
	[14] = u8"SUNNY_COUNTRYSIDE",
	[15] = u8"CLOUDY_COUNTRYSIDE",
	[16] = u8"RAINY_COUNTRYSIDE",
	[17] = u8"EXTRASUNNY_DESERT",
	[18] = u8"SUNNY_DESERT",
	[19] = u8"SANDSTORM_DESERT",
	[20] = u8"UNDER WATER",
	[21] = u8"EXTRACOLOURS_1",
	[22] = u8"EXTRACOLOURS_2"
}
local weatherchar = imgui.new['const char*'][#weather+1](weather)

local CTimeCycle = {
	m_nAmbientRed 				= ffi.cast("unsigned char*", memory.getuint32(0x560C61)),
	m_nAmbientGreen 			= ffi.cast("unsigned char*", memory.getuint32(0x55F4D6)),
	m_nAmbientBlue 				= ffi.cast("unsigned char*", memory.getuint32(0x55F4E8)),
	m_nAmbientRed_Obj 			= ffi.cast("unsigned char*", memory.getuint32(0x55F4FA)),
	m_nAmbientGreen_Obj 		= ffi.cast("unsigned char*", memory.getuint32(0x55F50C)),
	m_nAmbientBlue_Obj 			= ffi.cast("unsigned char*", memory.getuint32(0x55F51E)),
	m_nSkyTopRed 				= ffi.cast("unsigned char*", memory.getuint32(0x55F531)),
	m_nSkyTopGreen 				= ffi.cast("unsigned char*", memory.getuint32(0x55F53D)),
	m_nSkyTopBlue 				= ffi.cast("unsigned char*", memory.getuint32(0x55F549)),
	m_nSkyBottomRed				= ffi.cast("unsigned char*", memory.getuint32(0x55F555)),
	m_nSkyBottomGreen 			= ffi.cast("unsigned char*", memory.getuint32(0x55F561)),
	m_nSkyBottomBlue 			= ffi.cast("unsigned char*", memory.getuint32(0x55F56D)),
	m_nSunCoreRed 				= ffi.cast("unsigned char*", memory.getuint32(0x55F579)),
	m_nSunCoreGreen 			= ffi.cast("unsigned char*", memory.getuint32(0x55F585)),
	m_nSunCoreBlue 				= ffi.cast("unsigned char*", memory.getuint32(0x55F591)),
	m_nSunCoronaRed 			= ffi.cast("unsigned char*", memory.getuint32(0x55F59D)),
	m_nSunCoronaGreen 			= ffi.cast("unsigned char*", memory.getuint32(0x55F5A9)),
	m_nSunCoronaBlue 			= ffi.cast("unsigned char*", memory.getuint32(0x55F5B5)),
	m_fSunSize 					= ffi.cast("unsigned char*", memory.getuint32(0x55F5C0)),
	m_fSpriteSize 				= ffi.cast("unsigned char*", memory.getuint32(0x55F5D2)),
	m_fSpriteBrightness 		= ffi.cast("unsigned char*", memory.getuint32(0x55F5E4)),
	m_nShadowStrength 			= ffi.cast("unsigned char*", memory.getuint32(0x55F5F7)),
	m_nLightShadowStrength		= ffi.cast("unsigned char*", memory.getuint32(0x55F603)),
	m_nPoleShadowStrength 		= ffi.cast("unsigned char*", memory.getuint32(0x55F60F)),
	m_fFarClip 					= ffi.cast("short*", memory.getuint32(0x55F61B)),
	m_fFogStart 				= ffi.cast("short*", memory.getuint32(0x55F62E)),
	m_fLightsOnGroundBrightness = ffi.cast("unsigned char*", memory.getuint32(0x55F640)),
	m_nLowCloudsRed 			= ffi.cast("unsigned char*", memory.getuint32(0x55F653)),
	m_nLowCloudsGreen 			= ffi.cast("unsigned char*", memory.getuint32(0x55F65F)),
	m_nLowCloudsBlue 			= ffi.cast("unsigned char*", memory.getuint32(0x55F66B)),
	m_nFluffyCloudsBottomRed 	= ffi.cast("unsigned char*", memory.getuint32(0x55F677)),
	m_nFluffyCloudsBottomGreen 	= ffi.cast("unsigned char*", memory.getuint32(0x55F683)),
	m_nFluffyCloudsBottomBlue 	= ffi.cast("unsigned char*", memory.getuint32(0x55F690)),
	m_fWaterRed 				= ffi.cast("unsigned char*", memory.getuint32(0x55F69C)),
	m_fWaterGreen 				= ffi.cast("unsigned char*", memory.getuint32(0x55F6B0)),
	m_fWaterBlue 				= ffi.cast("unsigned char*", memory.getuint32(0x55F6C3)),
	m_fWaterAlpha 				= ffi.cast("unsigned char*", memory.getuint32(0x55F6D6)),
	m_fPostFx1Red 				= ffi.cast("unsigned char*", memory.getuint32(0x55F6E9)),
	m_fPostFx1Green 			= ffi.cast("unsigned char*", memory.getuint32(0x55F6FC)),
	m_fPostFx1Blue 				= ffi.cast("unsigned char*", memory.getuint32(0x55F70F)),
	m_fPostFx1Alpha 			= ffi.cast("unsigned char*", memory.getuint32(0x55F725)),
	m_fPostFx2Red 				= ffi.cast("unsigned char*", memory.getuint32(0x55F73B)),
	m_fPostFx2Green 			= ffi.cast("unsigned char*", memory.getuint32(0x55F751)),
	m_fPostFx2Blue 				= ffi.cast("unsigned char*", memory.getuint32(0x55F767)),
	m_fPostFx2Alpha 			= ffi.cast("unsigned char*", memory.getuint32(0x55F77D)),
	m_fCloudAlpha 				= ffi.cast("unsigned char*", memory.getuint32(0x55F793)),
	m_nHighLightMinIntensity 	= ffi.cast("unsigned char*", memory.getuint32(0x55F7A9)),
	m_nWaterFogAlpha 			= ffi.cast("unsigned char*", memory.getuint32(0x55F7B8)),
	m_nDirectionalMult 			= ffi.cast("unsigned char*", memory.getuint32(0x55F7C7)),
	-- funcs
	Initialise 					= ffi.cast("void (__cdecl*)(void)", 0x5BBAC0)
}

local CurrWeather 	= ffi.cast("short*", 0xC81320)
local NextWeather 	= ffi.cast("short*", 0xC8131C)
local Hours 		= ffi.cast("unsigned char*", 0xB70153)
local Minutes 		= ffi.cast("unsigned char*", 0xB70152)
local Seconds 		= ffi.cast("unsigned short*", 0xB70150)
local TimeScale 	= ffi.cast("unsigned int*", 0xB7015C)
local NUMWEATHERS 	= 23

local Im = {
	CurrWeather 		= new.int(CurrWeather[0]),
	NextWeather 		= new.int(NextWeather[0]),
}

--=========================================| END | =====================================
local fonts = {}
imgui.OnInitialize(function()

    imgui.GetIO().IniFilename = nil
    SwitchTheStyle(ini.settings.theme)
    local config = imgui.ImFontConfig()
    config.OversampleH = 2
    config.MergeMode = true
 
    local path = getFolderPath(0x14) .. '\\tahomabd.ttf'
    local path2 = getFolderPath(0x14) .. '\\tahomabd.ttf'
    --local path3 = getFolderPath(0x14) .. '\\tahomabd.TTF'


    local builder = imgui.ImFontGlyphRangesBuilder()
          for k,v in ipairs({"\xef\x80\x95", "\xef\x80\x93", "\xef\x84\x88", "\xef\x86\x86", "\xef\x96\xaa", "\xef\x80\xa8", "\xef\x83\x89", "\xef\x82\x85"}) do
             builder:AddText(v)
          end

          local frn = imgui.ImVector_ImWchar()
        builder:BuildRanges(frn)


        
    
    fonts[22] = imgui.GetIO().Fonts:AddFontFromFileTTF(path, 22, nil)
    logofont = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/gamefixer/fonts/fa-solid-900.ttf', 32.0, config, frn[0].Data)
    fonts[14] = imgui.GetIO().Fonts:AddFontFromFileTTF(path2, 14.5, nil)
    fonts[15] = imgui.GetIO().Fonts:AddFontFromFileTTF(path, 16, nil)

     
    iconFont = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/gamefixer/fonts/fa-solid-900.ttf', 15.0, config, frn[0].Data)
end)

------------------------------------------ [FFI cdef] ---------------------------
ffi.cdef [[
	typedef unsigned long HANDLE;
	typedef HANDLE HWND;
	typedef struct _RECT {
		long left;
		long top;
		long right;
		long bottom;
	} RECT, *PRECT;

	HWND GetActiveWindow(void);

	bool GetWindowRect(
		HWND   hWnd,
		PRECT lpRect
	);

	bool ClipCursor(const RECT *lpRect);

	bool GetClipCursor(PRECT lpRect);
    
    //----------------------
    typedef unsigned int UINT;
    typedef unsigned long DWORD;
    typedef DWORD HRESULT;
    typedef long LONG;
    typedef int BOOL;
    typedef enum _D3DFORMAT { __D3DFORMAT } D3DFORMAT; 
    typedef enum _D3DMULTISAMPLE_TYPE { __D3DMULTISAMPLE_TYPE } D3DMULTISAMPLE_TYPE;
    typedef enum _D3DSWAPEFFECT { __D3DSWAPEFFECT } D3DSWAPEFFECT;
    typedef struct _HWND* HWND;

    typedef struct _IDirect3DDevice9 IDirect3DDevice9;

    typedef struct _RGNDATAHEADER {
        DWORD dwSize;
        DWORD iType;
        DWORD nCount;
        DWORD nRgnSize;
        RECT  rcBound;
    } RGNDATAHEADER;

    typedef struct _RGNDATA {
        RGNDATAHEADER rdh;
        char          Buffer[1];
    } RGNDATA;

    typedef struct _D3DPRESENT_PARAMETERS {
        UINT                BackBufferWidth;
        UINT                BackBufferHeight;
        D3DFORMAT           BackBufferFormat;
        UINT                BackBufferCount;
        D3DMULTISAMPLE_TYPE MultiSampleType;
        DWORD               MultiSampleQuality;
        D3DSWAPEFFECT       SwapEffect;
        HWND                hDeviceWindow;
        BOOL                Windowed;
        BOOL                EnableAutoDepthStencil;
        D3DFORMAT           AutoDepthStencilFormat;
        DWORD               Flags;
        UINT                FullScreen_RefreshRateInHz;
        UINT                PresentationInterval;
    } D3DPRESENT_PARAMETERS;

    typedef union _LARGE_INTEGER {
        struct {
        long LowPart;
        long HighPart;
        };
        long long QuadPart;
    } LARGE_INTEGER;

    //kernel32
    int __stdcall QueryPerformanceCounter(LARGE_INTEGER* performanceCount);
    int __stdcall QueryPerformanceFrequency(LARGE_INTEGER* frequency);

    //winmm
    DWORD __stdcall timeGetTime(void);

    typedef unsigned int uint16;
    typedef unsigned int uint8;
]]

-------------------------------------------------------------------
local kernel32 = ffi.load("Kernel32.dll")
local winmm = ffi.load("winmm.dll")
local hooks = require("hooks")
local TARGET_FRAMERATE = 100
-------------------------------------------------------------------
local rcClip, rcOldClip = ffi.new('RECT'), ffi.new('RECT')
----------------------------------------------------------------------------------------
------------------------------------ [cleaner] --------------------------------------------
local function round(num, idp)
    local mult = 10 ^ (idp or 0)
    return math.floor(num * mult + 0.5) / mult
end

function get_memory()
    return round(memory.read(0x8E4CB4, 4, true) / 1048576, 1)
end
-------------------------------------------------------------------------------------------------

function GetMaxPlayerId(condition)
    return 1000 -- irrelevante
end

-------------------------------------------------------------------------------------------------

local created = false

local mainLoaded = false

function main()
    jit.off(_, false)-- hehe nice!
    if not mainLoaded then
        mainLoaded = true
        resethook()
        --------------------- [ dual monitor fix] --------------
        ffi.C.GetWindowRect(ffi.C.GetActiveWindow(), rcClip);
        ffi.C.ClipCursor(rcClip);
        --------------------------------------------------------
        repeat wait(1) until isSampAvailable()
        gotofunc("all")--load all func
        presenthook()
        lua_thread.create(ultimategenrl)
        bindOpenmenu = rkeys.registerHotKey(ActOpenMenuKey.v, true, function()
            if not sampIsCursorActive() then
                gfmenu.switch()
            end
        end)
        sampAddChatMessage(script_name.."{FFFFFF} Menú: {dc4747}"..ini.commands.openmenu.." {FFFFFF}o {dc4747}"..table.concat(rkeys.getKeysName(ActOpenMenuKey.v), " + ")..". {FFFFFF}Versión: {dc4747}"..script_version.." {FFFFFF}Autor: {dc4747}"..script_author, 0x73b461)
        loadSounds()--ugenrl
        addEventHandler('onWindowMessage', function(msg, wparam, lparam)
            if wparam == 27 then
                if gfmenu.state or twsmenu.state then
                    if msg == wm.WM_KEYDOWN then
                        consumeWindowMessage(true, false)
                    end
                    if msg == wm.WM_KEYUP then
                        if gfmenu.state then
                            gfmenu.switch()
                        elseif twsmenu.state then
                            twsmenu.switch()
                        end
                    end
                end
            end
            if ini.settings.mapzoomfixer then
                if (msg == 522 and readMemory(0xBA68A5, 1, true) == 5) then
                    if wparam == 7864320 and memory.getfloat(0xBA67AC, true) < 1000.0 then
                        memory.setfloat(0xBA67AC, memory.getfloat(0xBA67AC, true) + 42.0, false)
                    elseif wparam == 4287102976 and memory.getfloat(0xBA67AC, true) > 300.0 then
                        memory.setfloat(0xBA67AC, memory.getfloat(0xBA67AC, true) - 42.0, false)
                    end
                end
            end
            if ini.settings.dual_monitor_fix then
                if msg == wm.WM_KILLFOCUS then
                    ffi.C.GetClipCursor(rcOldClip);
                    ffi.C.ClipCursor(rcOldClip);
                elseif msg == wm.WM_SETFOCUS then
                    ffi.C.GetWindowRect(ffi.C.GetActiveWindow(), rcClip);
                    ffi.C.ClipCursor(rcClip);
                end
            end
            if ini.nop_samp_keys.key_ALTENTER and msg == 261 and wparam == 13 then
                consumeWindowMessage(true, true)
            end
            
        end)
        if getModuleHandle("timecycle24.asi") ~= 0 or getModuleHandle("timecycle24") ~= 0 then
            NUMHOURS = 24
            bTimecyc24h = true
        else
            NUMHOURS = 8
            bTimecyc24h = false
        end
        cntfont()

    end
        while true do
            wait(0)

            if isCharOnFoot(PLAYER_PED) and TARGET_FRAMERATE ~= ini.smart_fps.pedfps and not isCharSwimming(PLAYER_PED) and getCurrentCharWeapon(PLAYER_PED) ~= 34 and getCurrentCharWeapon(PLAYER_PED) ~= 41 then
                TARGET_FRAMERATE = ini.smart_fps.pedfps
            elseif isCharOnFoot(PLAYER_PED) and TARGET_FRAMERATE ~= ini.smart_fps.snipergunfps and not isCharSwimming(PLAYER_PED) and getCurrentCharWeapon(PLAYER_PED) == 34 then
                TARGET_FRAMERATE = ini.smart_fps.snipergunfps
            elseif isCharOnFoot(PLAYER_PED) and TARGET_FRAMERATE ~= ini.smart_fps.spraygunfps and not isCharSwimming(PLAYER_PED) and getCurrentCharWeapon(PLAYER_PED) == 41 then
                TARGET_FRAMERATE = ini.smart_fps.spraygunfps
            end
            if isCharInAnyHeli(PLAYER_PED) and TARGET_FRAMERATE ~= ini.smart_fps.helifps then
                TARGET_FRAMERATE = ini.smart_fps.helifps
            elseif isCharInAnyPlane(PLAYER_PED) and TARGET_FRAMERATE ~= ini.smart_fps.planefps then
                TARGET_FRAMERATE = ini.smart_fps.planefps
            elseif isCharInAnyCar(PLAYER_PED) and not isCharInAnyPlane(PLAYER_PED) and not isCharInAnyHeli(PLAYER_PED) and not isCharInAnyBoat(PLAYER_PED) then
                if isCharInAnyMotoBike(PLAYER_PED) and TARGET_FRAMERATE ~= ini.smart_fps.motofps then
                    TARGET_FRAMERATE = ini.smart_fps.motofps
                end
                if isCharInAnyBike(PLAYER_PED) and TARGET_FRAMERATE ~= ini.smart_fps.bikefps then
                    TARGET_FRAMERATE = ini.smart_fps.bikefps
                end
                if isCharSittingInAnyCar(PLAYER_PED) and not isCharInAnyPlane(PLAYER_PED) and not isCharInAnyHeli(PLAYER_PED) and not isCharInAnyMotoBike(PLAYER_PED) and not isCharInAnyBike(PLAYER_PED) and TARGET_FRAMERATE ~= ini.smart_fps.vehfps then
                    TARGET_FRAMERATE = ini.smart_fps.vehfps
                end
            elseif isCharInAnyBoat(PLAYER_PED) and TARGET_FRAMERATE ~= ini.smart_fps.boatfps then
                TARGET_FRAMERATE = ini.smart_fps.boatfps
            elseif isCharSwimming(PLAYER_PED) and TARGET_FRAMERATE ~= ini.smart_fps.swimfps then
                TARGET_FRAMERATE = ini.smart_fps.swimfps
            end
            
            if tonumber(("%.2f"):format(memory.getfloat(0x8CD800, true))) ~= ini.settings.lod_scale then
                memory.setfloat(0x8CD800, ini.settings.lod_scale, true)
            end

            if ini.cleaner.autoclean then
                if tonumber(get_memory()) > tonumber(ini.cleaner.limit) then
                    gotofunc("CleanMemory")
                end
            end

            --arreglar fotografía de error
            if getCurrentCharWeapon(PLAYER_PED) == 43 and readMemory(0x70476E, 4, true) == 2866 and readMemory(0x53E227, 1, true) ~= 233 then
                writeMemory(0x53E227, 1, 0xE9, true)
            elseif getCurrentCharWeapon(PLAYER_PED) ~= 43 and readMemory(0x53E227, 1, true) ~= 195 and readMemory(0x70476E, 4, true) == 2866 then
                writeMemory(0x53E227, 1, 0xC3, true)
            end
             --arreglar fotografía de error
            if ini.settings.sync_time and not ini.settings.gtatime then
                if memory.read(0xB70153, 1, true) ~= os.date("%H") then
                    ini.settings.hours = os.date("%H")
                    gotofunc("SetTime")
                end
                if memory.read(0xB70152, 1, true) ~= os.date("%M") then
                    ini.settings.min = os.date("%M")
                    gotofunc("SetTime")
                end
            end

            if not ini.settings.sync_time and not ini.settings.gtatime then
                if ini.settings.blockweather == true and memory.read(0xC81320, 2, true) ~= ini.settings.weather then gotofunc("SetWeather") end
                if ini.settings.blocktime == true and memory.read(0xB70153, 1, true) ~= ini.settings.hours then gotofunc("SetTime") end
            end

            if not sampIsCursorActive() then
                if ini.settings.chatt and isKeyJustPressed(84) then
                    sampSetChatInputEnabled(true)
                end
            end
            if ini.settings.antiblockedplayer and not isCharInAnyCar(PLAYER_PED) then
                for i = 0, GetMaxPlayerId(true) do
                    if sampIsPlayerConnected(i) then
                        local result, id = sampGetCharHandleBySampPlayerId(i)
                        if result then
                            if isCharOnScreen(id) and doesCharExist(id) then
                                local x, y, z = getCharCoordinates(id)
                                local mX, mY, mZ = getCharCoordinates(PLAYER_PED)
                                if 0.64 > getDistanceBetweenCoords3d(x, y, z, mX, mY, mZ) then
                                    setCharCollision(id, false)
                                end
                            end
                        end
                    end
                end
            end

            if ini.settings.givemedist and not doesFileExist(getGameDirectory()..'\\_CoreGame.asi') then
                if isCharInAnyPlane(PLAYER_PED) or isCharInAnyHeli(PLAYER_PED) then --airveh dist
                    if memory.getfloat(0xB7C7F0, true) ~= ini.settings.drawdistair then
                        memory.setfloat(0xB7C7F0, ini.settings.drawdistair, true)
                        memory.setfloat(0xC992F0, ini.settings.fog, true)
                    end
                else
                    if memory.getfloat(0xB7C7F0, true) ~= ini.settings.drawdist and getCurrentCharWeapon(PLAYER_PED) ~= 46 then
                        memory.setfloat(0xB7C7F0, ini.settings.drawdist, true)
                        memory.setfloat(0xC992F0, ini.settings.fog, true)
                    end
                    if tonumber(("%.1f"):format(memory.getfloat(0xB7C7F0, true))) ~= ini.settings.drawdistpara and getCurrentCharWeapon(PLAYER_PED) == 46 then
                        memory.setfloat(0xB7C7F0, ini.settings.drawdistpara, true)
                    end
                end

                if memory.getfloat(0xC992F0, true) >= memory.getfloat(0xB7C7F0, true) then --fix bug dist
                    memory.setfloat(0xC992F0, ini.settings.drawdist - 1.0, true)
                    ini.settings.fog = ini.settings.drawdist - 1.0
                    save()
                end
            end

            if sampGetGamestate() == 3 and not created then
                sampTextdrawCreate(1978, "_", -10000, -10000)	
                created = true
            end
            if created and not sampTextdrawIsExists(1978) then
                created = false
            end 


            if created then
                sampTextdrawSetLetterSizeAndColor(1978, 0.220, 0.930, 4294967295)
                sampTextdrawSetPos(1978, ini.hphud.posX, ini.hphud.posY)
                sampTextdrawSetStyle(1978, ini.hphud.fonts)
                sampTextdrawSetAlign(1978, ini.hphud.posX)
                sampTextdrawSetOutlineColor(1978, 1, 4278190080)
                if ini.hphud.status and not sampIsScoreboardOpen() and readMemory(0xBA676C, 1, true) == 0 then
                    local hp = getCharHealth(PLAYER_PED)
                    if hp > 160 then hp = "160_+" end
                    sampTextdrawSetString(1978, hp..""..hptext())
                else
                    sampTextdrawSetString(1978, "_")
                end
            end
        end
end

function math.clamp(x, min, max)
    return math.max(math.min(x, max), min)
end


function ultimategenrl()
    while true do wait(0)
        if ini.ugenrl_main.enable and sampGetGamestate() == 3 then
            if ini.ugenrl_main.mode == 0 or ini.ugenrl_main.mode == 1 then
                if ini.ugenrl_main.weapon then
                    if isCharShooting(PLAYER_PED) then
                        playSound(ini.ugenrl_sounds[getCurrentCharWeapon(PLAYER_PED)], ini.ugenrl_volume.weapon)
                    end
                    if ini.ugenrl_main.enemyWeapon then
                        local myX, myY, myZ = getCharCoordinates(PLAYER_PED)
                        repeat
                            local hasFoundChars, randomCharHandle = findAllRandomCharsInSphere(myX, myY, myZ, ini.ugenrl_main.enemyWeaponDist, true, true)			
                            if hasFoundChars and hasFoundChars ~= nil and isCharShooting(randomCharHandle) then
                                playSound(ini.ugenrl_sounds[getCurrentCharWeapon(randomCharHandle)], ini.ugenrl_volume.weapon, randomCharHandle)
                            end
                        until not hasFoundChars
                    end
                end
                if playPain then
                    playSound(ini.ugenrl_sounds.pain, ini.ugenrl_volume.pain)
                    playPain = false
                    if weaponSoundDelay[dmgWeaponId] then wait(weaponSoundDelay[dmgWeaponId]) end
                end
            end
            if playHit then
                playSound(ini.ugenrl_sounds.hit, ini.ugenrl_volume.hit)
                playHit = false
                if weaponSoundDelay[dmgWeaponId] then wait(weaponSoundDelay[dmgWeaponId]) end
            end
            if isExpl() then
                playSound(ini.ugenrl_sounds.expl, ini.ugenrl_volume.expl)
            end
        end
    end
end

function isCharInAnyMotoBike(handle)
    local modelid = getCarModel(storeCarCharIsInNoSave(handle))
    return modelid == 461 or modelid == 462 or modelid == 463 or modelid == 468 or modelid == 521 or modelid == 522 or modelid == 523 or modelid == 581 or modelid == 586
end

function isCharInAnyBike(handle)
    local modelid = getCarModel(storeCarCharIsInNoSave(handle))
    return modelid == 481 or modelid == 509 or modelid == 510
end

local tab = new.int(1)
local tabs = {
    fa.ICON_FA_HOME..u8'\tPrincipal',
    fa.ICON_FA_COG..u8'\tCorrecciones',
    fa.ICON_FA_DESKTOP..u8'\tPara FPS',
    fa.ICON_FA_MOON..u8'\tTimecyc Editor',
    fa.ICON_FA_PAINT_ROLLER..u8'\tInterfaz de juego',
    fa.ICON_FA_VOLUME_UP..u8'\tSonidos',
    fa.ICON_FA_BARS..u8'\tComandos',
}

local sab = new.int(1)
local sabs = {
    u8'Salud',
    u8'Dinero',
    u8'Radar',
    u8'Menú del juego',
    u8'Apuntar',
    u8'Colores de la interfaz',
    u8'Otro',
}

local dab = new.int(1)
local dabs = {
    u8'Distancia de dibujado',
    u8'Distancia de objetos',
    u8'Editor de sombras',
    u8'Limpieza de memoria',
    u8'Administrador de efectos',
    u8'Limitador de FPS',
    u8'Otros',
}

local twsrender = imgui.OnFrame(
    function() return twsmenu.alpha > 0.00 end,
    function(self)
        self.HideCursor = not twsmenu.state
        if isKeyDown(32) and self.HideCursor == false then
            self.HideCursor = true
        elseif not isKeyDown(32) and self.HideCursor == true and twsmenu.state then
            self.HideCursor = false
        end
        imgui.PushStyleVarFloat(imgui.StyleVar.Alpha, twsmenu.alpha)
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(100, 100), imgui.Cond.FirstUseEver)
        imgui.Begin(u8"[GameFixer] Editor de clima y tiempo", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.NoTitleBar)
        if ini.settings.blockweather then
            imgui.Text(u8"Clima:")
            imgui.SameLine()
            imgui.SetCursorPosX(70)
            if imgui.SliderInt(u8"##Weather", sliders.weather, 0, 45) then
                ini.settings.weather = sliders.weather[0]
                save()
                gotofunc("SetWeather")
            end
        end
        if ini.settings.blocktime then
            if not ini.settings.gtatime and not ini.settings.sync_time then
                imgui.Text(u8"Hora:")
                imgui.SameLine()
                imgui.SetCursorPosX(70)
                if imgui.SliderInt(u8"##hours", sliders.hours, 0, 23) then
                    ini.settings.hours = sliders.hours[0]
                    save()
                    gotofunc("SetTime")
                end
                imgui.Text(u8"Minutos:")
                imgui.SameLine()
                imgui.SetCursorPosX(70)
                if imgui.SliderInt(u8"##min", sliders.min, 0, 59) then
                    ini.settings.min = sliders.min[0]
                    save()
                    gotofunc("SetTime")
                end
            end
        end
        if imgui.Checkbox(u8"Bloquear el cambio de clima por el servidor", checkboxes.blockweather) then
            ini.settings.blockweather = checkboxes.blockweather[0]
            save()
            gotofunc("BlockWeather")
            gotofunc("SetWeather")
        end
        if imgui.Checkbox(u8"Bloquear el servidor para que no cambie la hora", checkboxes.blocktime) then
            ini.settings.blocktime = checkboxes.blocktime[0]
            save()
            gotofunc("BlockTime")
            gotofunc("SetTime")
        end
        if ini.settings.blocktime then
            if imgui.Checkbox(u8"Sincronización de tiempo de juego con PC", checkboxes.sync_time) then
                ini.settings.sync_time = checkboxes.sync_time[0]
                save()
            end
            if imgui.Checkbox(u8"Habilitar bucle de tiempo desde un solo jugador", checkboxes.gtatime) then
                ini.settings.gtatime = checkboxes.gtatime[0]
                gotofunc("GTATime")
                save()
            end
        end
        imgui.End()
        imgui.PopStyleVar()
    end
)

local newFrame = imgui.OnFrame(
    function() return gfmenu.alpha > 0.00 end,
    function(self)
        self.HideCursor = not gfmenu.state
        if isKeyDown(32) and self.HideCursor == false then
            self.HideCursor = true
        elseif not isKeyDown(32) and self.HideCursor == true and gfmenu.state then
            self.HideCursor = false
        end
        imgui.PushStyleVarFloat(imgui.StyleVar.Alpha, gfmenu.alpha)
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(910, 590), imgui.Cond.FirstUseEver)
        imgui.PushStyleVarVec2(imgui.StyleVar.WindowPadding, imgui.ImVec2(0, 0))
        imgui.Begin("##GameFixer", new.bool(true), imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoTitleBar)
                imgui.SetCursorPos(imgui.ImVec2(0, 0))
                imgui.PushStyleColor(imgui.Col.ChildBg, imgui.ImVec4(0.0, 0.0, 0.0, 0.0))
                imgui.BeginChild("##LeftMenu", imgui.ImVec2(170, 500), false)
                    imgui.SetCursorPos(imgui.ImVec2(7, 40))
                    imgui.PushFont(fonts[22])
                    imgui.PushFont(logofont)
                    if ini.settings.theme == 1 or ini.settings.theme == nil or ini.settings.theme == 0 then
                        imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(ini.logocolor.r, ini.logocolor.g, ini.logocolor.b, ini.logocolor.a))
                    else
                        imgui.PushStyleColor(imgui.Col.Text, imgui.GetStyle().Colors[imgui.Col.ButtonHovered])
                    end
                    imgui.SetCursorPosX(10)
                    imgui.Text(fa.ICON_FA_COGS..u8"  GameFixer")
                    imgui.PopStyleColor(1)
                    imgui.PopFont()
                    imgui.PopFont()

                    imgui.SetCursorPos(imgui.ImVec2(0, 100))
                    imgui.PushFont(fonts[15])
                    imgui.PushFont(iconFont)
                    imgui.CustomMenu(tabs, tab, imgui.ImVec2(200, 32))
                    imgui.PopFont()
                    imgui.PopFont()
                   
                imgui.EndChild()
                imgui.SetCursorPos(imgui.ImVec2(20, imgui.GetWindowSize().y - 40))
                imgui.Text(u8"Autor:")
                imgui.SameLine()
                imgui.Link("https://vk.com/gorskinscripts", "Gorskin")
                imgui.SetCursorPos(imgui.ImVec2(20, imgui.GetWindowSize().y - 20))
                imgui.Text(u8"Versión:") imgui.SameLine()
                imgui.TextColored(imgui.ImVec4(0.40, 0.40, 0.40, 0.70), script_version)
                imgui.PopStyleColor(1)
                imgui.SameLine()
                imgui.PushStyleVarVec2(imgui.StyleVar.WindowPadding, imgui.ImVec2(10, 10))
                
                imgui.PushStyleVarFloat(imgui.StyleVar.ChildRounding, 0)
                
                imgui.SetCursorPos(imgui.ImVec2(170, 0))
                    imgui.PushStyleVarFloat(imgui.StyleVar.ChildBorderSize, 0)
                    imgui.BeginChild("##MainMenu", imgui.ImVec2(imgui.GetWindowSize().x, imgui.GetWindowSize().y), true)
                    imgui.SetCursorPos(imgui.ImVec2(imgui.GetWindowSize().x-200, 7))
                    if CloseButton("##Close", new.bool(true), 0) then
                        gfmenu.switch()
                    end
                    imgui.SetCursorPos(imgui.ImVec2(0, 35))
                    imgui.PopStyleVar()
                    imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.0, 0.0, 0.0, 0.0))
                    imgui.PushStyleColor(imgui.Col.ChildBg, imgui.ImVec4(0.0, 0.0, 0.0, 0.0))
                    imgui.BeginChild("##MainMenuVnutri", imgui.ImVec2(imgui.GetWindowSize().x - 175, imgui.GetWindowSize().y - 40), true)
                    imgui.PopStyleColor(2)
                    imgui.PushFont(fonts[14])
                    if tab[0] == 1 then
                        imgui.BeginTitleChild(u8"Clima y Hora", imgui.ImVec2(335, 230), 7, 120, false)
                        if ini.settings.blockweather then
                            imgui.Text(u8"Clima:")
                            imgui.SameLine()
                            imgui.SetCursorPosX(70)
                            if imgui.SliderInt(u8"##Weather", sliders.weather, 0, 45) then
                                ini.settings.weather = sliders.weather[0]
                                save()
                                gotofunc("SetWeather")
                            end
                        end
                        if ini.settings.blocktime then
                            if not ini.settings.gtatime and not ini.settings.sync_time then
                                imgui.Text(u8"Hora:")
                                imgui.SameLine()
                                imgui.SetCursorPosX(70)
                                if imgui.SliderInt(u8"##hours", sliders.hours, 0, 23) then
                                    ini.settings.hours = sliders.hours[0]
                                    save()
                                    gotofunc("SetTime")
                                end
                                imgui.Text(u8"Minutos:")
                                imgui.SameLine()
                                imgui.SetCursorPosX(70)
                                if imgui.SliderInt(u8"##min", sliders.min, 0, 59) then
                                    ini.settings.min = sliders.min[0]
                                    save()
                                    gotofunc("SetTime")
                                end
                            end
                        end
                        if imgui.Checkbox(u8"Bloquear el cambio de clima por el servidor", checkboxes.blockweather) then
                            ini.settings.blockweather = checkboxes.blockweather[0]
                            save()
                            gotofunc("BlockWeather")
                            gotofunc("SetWeather")
                        end
                        if imgui.Checkbox(u8"Bloquear el servidor para que no cambie la hora", checkboxes.blocktime) then
                            ini.settings.blocktime = checkboxes.blocktime[0]
                            save()
                            gotofunc("BlockTime")
                            gotofunc("SetTime")
                        end
                        if ini.settings.blocktime then
                            if imgui.Checkbox(u8"Sincronización de tiempo de juego con PC", checkboxes.sync_time) then
                                ini.settings.sync_time = checkboxes.sync_time[0]
                                save()
                            end
                            if imgui.Checkbox(u8"Habilitar bucle de tiempo desde un solo jugador", checkboxes.gtatime) then
                                ini.settings.gtatime = checkboxes.gtatime[0]
                                gotofunc("GTATime")
                                save()
                            end
                        end
                        imgui.EndChild()
                        imgui.SetCursorPos(imgui.ImVec2(370, 10))
                        imgui.BeginTitleChild(u8"bloqueo de teclas", imgui.ImVec2(335, 170), 7, 100, false)
                            if imgui.Checkbox(u8"Bloquear tecla F1", checkboxes.nop_samp_keys_F1) then
                                ini.nop_samp_keys.key_F1 = checkboxes.nop_samp_keys_F1[0]
                                save()
                                gotofunc("BlockSampKeys")
                            end
                            if imgui.Checkbox(u8"Bloquear tecla F4", checkboxes.nop_samp_keys_F4) then
                                ini.nop_samp_keys.key_F4 = checkboxes.nop_samp_keys_F4[0]
                                save()
                                gotofunc("BlockSampKeys")
                            end
                            if imgui.Checkbox(u8"Bloquear tecla F7", checkboxes.nop_samp_keys_F7) then
                                ini.nop_samp_keys.key_F7 = checkboxes.nop_samp_keys_F7[0]
                                save()
                                gotofunc("BlockSampKeys")
                            end
                            if imgui.Checkbox(u8"Bloquear tecla T", checkboxes.nop_samp_keys_T) then
                                ini.nop_samp_keys.key_T = checkboxes.nop_samp_keys_T[0]
                                save()
                                gotofunc("BlockSampKeys")
                            end
                            if imgui.Checkbox(u8"Bloquear el modo de ventana (ALT+ENTER)", checkboxes.nop_samp_keys_ALTENTER) then
                                ini.nop_samp_keys.key_ALTENTER = checkboxes.nop_samp_keys_ALTENTER[0]
                                save()
                            end
                        imgui.EndChild()
                        imgui.SetCursorPos(imgui.ImVec2(370,imgui.GetCursorPosY()+4))
                        imgui.PushItemWidth(335)
                        if imgui.SliderInt(u8"##brightness", sliders.brightness, 0, 600, u8"Brillo del juego: %d") then
                            ini.settings.brightness = sliders.brightness[0]
                            save()
                            gotofunc("SetBrightness")
                        end

                        --imgui.SameLine()
                        imgui.SetCursorPosX(370)
                        imgui.Text(u8"Abrir menú Gamefixer:")
                        imgui.SameLine()
                        if imgui.HotKey("##openmenu", ActOpenMenuKey, tLastKeys, 100) then
                            rkeys.changeHotKey(bindOpenmenu, ActOpenMenuKey.v)
                            sampAddChatMessage(script_name.." {FFFFFF}Valor antiguo: {dc4747}" .. table.concat(rkeys.getKeysName(tLastKeys.v), " + ") .. "{ffffff} | Nuevo: {dc4747}" .. table.concat(rkeys.getKeysName(ActOpenMenuKey.v), " + "), 0x73b461)
                            ini.settings.openmenukeys = encodeJson(ActOpenMenuKey.v)
                            save()
                        end
    
                        imgui.PopItemWidth()
                        imgui.SetCursorPos(imgui.ImVec2(10, 270))
                        imgui.BeginTitleChild(u8"Descansar", imgui.ImVec2(700, 240), 7, 90, false)
                        imgui.PushItemWidth(120)
                        
                            local clrs = {
                                imgui.ImVec4(ini.Button.r, ini.Button.g, ini.Button.b, ini.Button.a),
                                imgui.ImVec4(1.00, 0.28, 0.28, 1.00),
                                imgui.ImVec4(0.98, 0.43, 0.26, 1.00),
                                imgui.ImVec4(0.26, 0.98, 0.85, 1.00),
                                imgui.ImVec4(0.10, 0.09, 0.12, 1.00),
                                imgui.ImVec4(0.41, 0.19, 0.63, 1.00),
                                imgui.ImVec4(0.10, 0.09, 0.12, 1.00),
                                imgui.ImVec4(0.20, 0.25, 0.29, 1.00),
                                imgui.ImVec4(0.457, 0.200, 0.303, 1.00),
                                imgui.ImVec4(0.00, 0.69, 0.33, 1.00),
                                imgui.ImVec4(0.46, 0.11, 0.29, 1.00),
                                imgui.ImVec4(0.13, 0.75, 0.55, 1.00),
                                imgui.ImVec4(0.73, 0.36, 0.00, 1.00),
                                imgui.ImVec4(0.26, 0.59, 0.98, 1.00),
                            }
                            imgui.Text(u8"Color del tema:")
                            imgui.SameLine()
                            imgui.PushFont(fonts[15])
                            if imgui.Button(fa.ICON_FA_PENCIL_ALT..u8"") then
                                ini.settings.theme = 1
                                save()
                                SwitchTheStyle(ini.settings.theme)
                            end
                            imgui.PopFont()
                            imgui.SameLine()
                            for i = 2, #tbStyle do
                                imgui.PushStyleColor(imgui.Col.CheckMark, clrs[i])
                                if ini.settings.theme == i then imgui.PushStyleColor(imgui.Col.FrameBg, imgui.ImVec4(0.80, 0.80, 0.80, 1.00)) end
                
                                if imgui.RadioButtonBool(u8"##tema"..i, ini.settings.theme == i and false or true) then
                                    ini.settings.theme = i
                                    save()
                                    SwitchTheStyle(ini.settings.theme)
                                    
                                end

                                if ini.settings.theme == i then imgui.PopStyleColor() end
                                imgui.SameLine()
                            end
                            imgui.PopStyleColor()

                            SwitchTheStyle(ini.settings.theme)

                            

                        if ini.settings.theme == 1 or ini.settings.theme == nil or ini.settings.theme == 0 then
                            imgui.SetCursorPos(imgui.ImVec2(360, 30))
                            imgui.BeginTitleChild(u8"Colores del panel izquierdo", imgui.ImVec2(300, 190), 7, 90, false)
                                imgui.Text(u8"Color de la pestaña activa arriba izq:") imgui.SameLine()
                                imgui.SetCursorPosX(250)
                                if imgui.ColorEdit4("##Color Panel Left Up", icolors.PLeftUp, imgui.ColorEditFlags.AlphaBar + imgui.ColorEditFlags.NoInputs) then
                                    ini.PLeftUp.r, ini.PLeftUp.g, ini.PLeftUp.b, ini.PLeftUp.a = tonumber(("%.3f"):format(icolors.PLeftUp[0])), tonumber(("%.3f"):format(icolors.PLeftUp[1])), tonumber(("%.3f"):format(icolors.PLeftUp[2])), tonumber(("%.3f"):format(icolors.PLeftUp[3]))
                                    save() 
                                end
                                imgui.Text(u8"Color de la pestaña activo abajo izq:") imgui.SameLine()
                                imgui.SetCursorPosX(250)
                                if imgui.ColorEdit4("##Color Panel Left Down", icolors.PLeftDown, imgui.ColorEditFlags.AlphaBar + imgui.ColorEditFlags.NoInputs) then
                                    ini.PLeftDown.r, ini.PLeftDown.g, ini.PLeftDown.b, ini.PLeftDown.a = tonumber(("%.3f"):format(icolors.PLeftDown[0])), tonumber(("%.3f"):format(icolors.PLeftDown[1])), tonumber(("%.3f"):format(icolors.PLeftDown[2])), tonumber(("%.3f"):format(icolors.PLeftDown[3]))
                                    save() 
                                end
                                imgui.Text(u8"pestaña activa arriba derecha:") imgui.SameLine()
                                imgui.SetCursorPosX(250)
                                if imgui.ColorEdit4("##Color Panel Right Up", icolors.PRightUp, imgui.ColorEditFlags.AlphaBar + imgui.ColorEditFlags.NoInputs) then
                                    ini.PRightUp.r, ini.PRightUp.g, ini.PRightUp.b, ini.PRightUp.a = tonumber(("%.3f"):format(icolors.PRightUp[0])), tonumber(("%.3f"):format(icolors.PRightUp[1])), tonumber(("%.3f"):format(icolors.PRightUp[2])), tonumber(("%.3f"):format(icolors.PRightUp[3]))
                                    save() 
                                end
                                imgui.Text(u8"pestaña activa abajo derecha:") imgui.SameLine()
                                imgui.SetCursorPosX(250)
                                if imgui.ColorEdit4("##Color Panel Right Down", icolors.PRightDown, imgui.ColorEditFlags.AlphaBar + imgui.ColorEditFlags.NoInputs) then
                                    ini.PRightDown.r, ini.PRightDown.g, ini.PRightDown.b, ini.PRightDown.a = tonumber(("%.3f"):format(icolors.PRightDown[0])), tonumber(("%.3f"):format(icolors.PRightDown[1])), tonumber(("%.3f"):format(icolors.PRightDown[2])), tonumber(("%.3f"):format(icolors.PRightDown[3]))
                                    save() 
                                end
                                imgui.Text(u8"Color de texto panel izq:") imgui.SameLine()
                                imgui.SetCursorPosX(250)
                                if imgui.ColorEdit4("##ActiveText", icolors.ActiveText,  imgui.ColorEditFlags.AlphaBar + imgui.ColorEditFlags.NoInputs) then
                                    ini.ActiveText.r, ini.ActiveText.g, ini.ActiveText.b, ini.ActiveText.a = tonumber(("%.3f"):format(icolors.ActiveText[0])), tonumber(("%.3f"):format(icolors.ActiveText[1])), tonumber(("%.3f"):format(icolors.ActiveText[2])), tonumber(("%.3f"):format(icolors.ActiveText[3]))
                                    save()
                                    SwitchTheStyle(1)
                                end
                                imgui.Text(u8"Color de texto2 panel izq:") imgui.SameLine()
                                imgui.SetCursorPosX(250)
                                if imgui.ColorEdit4("##PassiveText", icolors.PassiveText, imgui.ColorEditFlags.AlphaBar + imgui.ColorEditFlags.NoInputs) then
                                    ini.PassiveText.r, ini.PassiveText.g, ini.PassiveText.b, ini.PassiveText.a = tonumber(("%.3f"):format(icolors.PassiveText[0])), tonumber(("%.3f"):format(icolors.PassiveText[1])), tonumber(("%.3f"):format(icolors.PassiveText[2])), tonumber(("%.3f"):format(icolors.PassiveText[3]))
                                    save()
                                    SwitchTheStyle(1)
                                end
                            imgui.EndChild()
                            imgui.SetCursorPosY(60)
                            imgui.Text(u8"Color de fondo de la ventana:") imgui.SameLine()
                            imgui.SetCursorPosX(240)
                            if imgui.ColorEdit4("##WindowBG", icolors.WindowBG,  imgui.ColorEditFlags.AlphaBar + imgui.ColorEditFlags.NoInputs) then
                                ini.WindowBG.r, ini.WindowBG.g, ini.WindowBG.b, ini.WindowBG.a = tonumber(("%.3f"):format(icolors.WindowBG[0])), tonumber(("%.3f"):format(icolors.WindowBG[1])), tonumber(("%.3f"):format(icolors.WindowBG[2])), tonumber(("%.3f"):format(icolors.WindowBG[3]))
                                save()
                                SwitchTheStyle(1)
                            end
                            imgui.Text(u8"Color de fondo:") imgui.SameLine()
                            imgui.SetCursorPosX(240)
                            if imgui.ColorEdit4("##ChildBG", icolors.ChildBG,  imgui.ColorEditFlags.AlphaBar + imgui.ColorEditFlags.NoInputs) then
                                ini.ChildBG.r, ini.ChildBG.g, ini.ChildBG.b, ini.ChildBG.a = tonumber(("%.3f"):format(icolors.ChildBG[0])), tonumber(("%.3f"):format(icolors.ChildBG[1])), tonumber(("%.3f"):format(icolors.ChildBG[2])), tonumber(("%.3f"):format(icolors.ChildBG[3]))
                                save()
                                SwitchTheStyle(1)
                            end
                            imgui.Text(u8"Color de texto:") imgui.SameLine()
                            imgui.SetCursorPosX(240)
                            if imgui.ColorEdit4("##ColorText", icolors.ColorText, imgui.ColorEditFlags.AlphaBar + imgui.ColorEditFlags.NoInputs) then
                                ini.ColorText.r, ini.ColorText.g, ini.ColorText.b, ini.ColorText.a = tonumber(("%.3f"):format(icolors.ColorText[0])), tonumber(("%.3f"):format(icolors.ColorText[1])), tonumber(("%.3f"):format(icolors.ColorText[2])), tonumber(("%.3f"):format(icolors.ColorText[3]))
                                save()
                                SwitchTheStyle(1)
                            end
                            imgui.Text(u8"Color de fondo del marco:") imgui.SameLine()
                            imgui.SetCursorPosX(240)
                            if imgui.ColorEdit4("##FrameBg", icolors.FrameBg, imgui.ColorEditFlags.AlphaBar + imgui.ColorEditFlags.NoInputs) then
                                ini.FrameBg.r, ini.FrameBg.g, ini.FrameBg.b, ini.FrameBg.a = tonumber(("%.3f"):format(icolors.FrameBg[0])), tonumber(("%.3f"):format(icolors.FrameBg[1])), tonumber(("%.3f"):format(icolors.FrameBg[2])), tonumber(("%.3f"):format(icolors.FrameBg[3]))
                                save()
                                SwitchTheStyle(1)
                            end
                            imgui.Text(u8"Fondo del marco al pasar el mouse:") imgui.SameLine()
                            imgui.SetCursorPosX(240)
                            if imgui.ColorEdit4("##FrameBgHovered", icolors.FrameBgHovered, imgui.ColorEditFlags.AlphaBar + imgui.ColorEditFlags.NoInputs) then
                                ini.FrameBgHovered.r, ini.FrameBgHovered.g, ini.FrameBgHovered.b, ini.FrameBgHovered.a = tonumber(("%.3f"):format(icolors.FrameBgHovered[0])), tonumber(("%.3f"):format(icolors.FrameBgHovered[1])), tonumber(("%.3f"):format(icolors.FrameBgHovered[2])), tonumber(("%.3f"):format(icolors.FrameBgHovered[3]))
                                save()
                                SwitchTheStyle(1)
                            end
                            imgui.Text(u8"Color de fondo del marco activo:") imgui.SameLine()
                            imgui.SetCursorPosX(240)
                            if imgui.ColorEdit4("##FrameBgActive", icolors.FrameBgActive, imgui.ColorEditFlags.AlphaBar + imgui.ColorEditFlags.NoInputs) then
                                ini.FrameBgActive.r, ini.FrameBgActive.g, ini.FrameBgActive.b, ini.FrameBgActive.a = tonumber(("%.3f"):format(icolors.FrameBgActive[0])), tonumber(("%.3f"):format(icolors.FrameBgActive[1])), tonumber(("%.3f"):format(icolors.FrameBgActive[2])), tonumber(("%.3f"):format(icolors.FrameBgActive[3]))
                                save()
                                SwitchTheStyle(1)
                            end
                            imgui.Text(u8"Color de la marca:") imgui.SameLine()
                            imgui.SetCursorPosX(240)
                            if imgui.ColorEdit4("##CheckMark", icolors.CheckMark, imgui.ColorEditFlags.AlphaBar + imgui.ColorEditFlags.NoInputs) then
                                ini.CheckMark.r, ini.CheckMark.g, ini.CheckMark.b, ini.CheckMark.a = tonumber(("%.3f"):format(icolors.CheckMark[0])), tonumber(("%.3f"):format(icolors.CheckMark[1])), tonumber(("%.3f"):format(icolors.CheckMark[2])), tonumber(("%.3f"):format(icolors.CheckMark[3]))
                                save()
                                SwitchTheStyle(1)
                            end
                            imgui.Text(u8"Color del control deslizante:") imgui.SameLine()
                            imgui.SetCursorPosX(240)
                            if imgui.ColorEdit4("##SliderGrab", icolors.SliderGrab, imgui.ColorEditFlags.AlphaBar + imgui.ColorEditFlags.NoInputs) then
                                ini.SliderGrab.r, ini.SliderGrab.g, ini.SliderGrab.b, ini.SliderGrab.a = tonumber(("%.3f"):format(icolors.SliderGrab[0])), tonumber(("%.3f"):format(icolors.SliderGrab[1])), tonumber(("%.3f"):format(icolors.SliderGrab[2])), tonumber(("%.3f"):format(icolors.SliderGrab[3]))
                                save()
                                SwitchTheStyle(1)
                            end
                            imgui.Text(u8"Control deslizante activo:") imgui.SameLine()
                            imgui.SetCursorPosX(240)
                            if imgui.ColorEdit4("##SliderGrabActive", icolors.SliderGrabActive, imgui.ColorEditFlags.AlphaBar + imgui.ColorEditFlags.NoInputs) then
                                ini.SliderGrabActive.r, ini.SliderGrabActive.g, ini.SliderGrabActive.b, ini.SliderGrabActive.a = tonumber(("%.3f"):format(icolors.SliderGrabActive[0])), tonumber(("%.3f"):format(icolors.SliderGrabActive[1])), tonumber(("%.3f"):format(icolors.SliderGrabActive[2])), tonumber(("%.3f"):format(icolors.SliderGrabActive[3]))
                                save()
                                SwitchTheStyle(1)
                            end
                            imgui.Text(u8"Color del borde:") imgui.SameLine()
                            imgui.SetCursorPosX(240)
                            if imgui.ColorEdit4("##Button", icolors.Button, imgui.ColorEditFlags.AlphaBar + imgui.ColorEditFlags.NoInputs) then
                                ini.Button.r, ini.Button.g, ini.Button.b, ini.Button.a = tonumber(("%.3f"):format(icolors.Button[0])), tonumber(("%.3f"):format(icolors.Button[1])), tonumber(("%.3f"):format(icolors.Button[2])), tonumber(("%.3f"):format(icolors.Button[3]))
                                save()
                                SwitchTheStyle(1)
                            end
                            imgui.Text(u8"Color del botón del panel izq:") imgui.SameLine()
                            imgui.SetCursorPosX(240)
                            if imgui.ColorEdit4("##ButtonHovered", icolors.ButtonHovered, imgui.ColorEditFlags.AlphaBar + imgui.ColorEditFlags.NoInputs) then
                                ini.ButtonHovered.r, ini.ButtonHovered.g, ini.ButtonHovered.b, ini.ButtonHovered.a = tonumber(("%.3f"):format(icolors.ButtonHovered[0])), tonumber(("%.3f"):format(icolors.ButtonHovered[1])), tonumber(("%.3f"):format(icolors.ButtonHovered[2])), tonumber(("%.3f"):format(icolors.ButtonHovered[3]))
                                save()
                                SwitchTheStyle(1)
                            end
                            imgui.Text(u8"Color del botón en config. timecyc:") imgui.SameLine()
                            imgui.SetCursorPosX(240)
                            if imgui.ColorEdit4("##ButtonActive", icolors.ButtonActive, imgui.ColorEditFlags.AlphaBar + imgui.ColorEditFlags.NoInputs) then
                                ini.ButtonActive.r, ini.ButtonActive.g, ini.ButtonActive.b, ini.ButtonActive.a = tonumber(("%.3f"):format(icolors.ButtonActive[0])), tonumber(("%.3f"):format(icolors.ButtonActive[1])), tonumber(("%.3f"):format(icolors.ButtonActive[2])), tonumber(("%.3f"):format(icolors.ButtonActive[3]))
                                save()
                                SwitchTheStyle(1)
                            end
                            imgui.Text(u8"Color de selección:") imgui.SameLine()
                            imgui.SetCursorPosX(240)
                            if imgui.ColorEdit4("##Header", icolors.Header, imgui.ColorEditFlags.AlphaBar + imgui.ColorEditFlags.NoInputs) then
                                ini.Header.r, ini.Header.g, ini.Header.b, ini.Header.a = tonumber(("%.3f"):format(icolors.Header[0])), tonumber(("%.3f"):format(icolors.Header[1])), tonumber(("%.3f"):format(icolors.Header[2])), tonumber(("%.3f"):format(icolors.Header[3]))
                                save()
                                SwitchTheStyle(1)
                            end
                            imgui.Text(u8"Color al pasar el mouse en selección:") imgui.SameLine()
                            imgui.SetCursorPosX(240)
                            if imgui.ColorEdit4("##HeaderHovered", icolors.HeaderHovered, imgui.ColorEditFlags.AlphaBar + imgui.ColorEditFlags.NoInputs) then
                                ini.HeaderHovered.r, ini.HeaderHovered.g, ini.HeaderHovered.b, ini.HeaderHovered.a = tonumber(("%.3f"):format(icolors.HeaderHovered[0])), tonumber(("%.3f"):format(icolors.HeaderHovered[1])), tonumber(("%.3f"):format(icolors.HeaderHovered[2])), tonumber(("%.3f"):format(icolors.HeaderHovered[3]))
                                save()
                                SwitchTheStyle(1)
                            end
                            imgui.Text(u8"Color de sombreado en selección:") imgui.SameLine()
                            imgui.SetCursorPosX(240)
                            if imgui.ColorEdit4("##HeaderActive", icolors.HeaderActive, imgui.ColorEditFlags.AlphaBar + imgui.ColorEditFlags.NoInputs) then
                                ini.HeaderActive.r, ini.HeaderActive.g, ini.HeaderActive.b, ini.HeaderActive.a = tonumber(("%.3f"):format(icolors.HeaderActive[0])), tonumber(("%.3f"):format(icolors.HeaderActive[1])), tonumber(("%.3f"):format(icolors.HeaderActive[2])), tonumber(("%.3f"):format(icolors.HeaderActive[3]))
                                save()
                                SwitchTheStyle(1)
                            end
                            imgui.Text(u8"Color de fondo de la barra derecha:") imgui.SameLine()
                            imgui.SetCursorPosX(240)
                            if imgui.ColorEdit4("##ScrollbarBg", icolors.ScrollbarBg, imgui.ColorEditFlags.AlphaBar + imgui.ColorEditFlags.NoInputs) then
                                ini.ScrollbarBg.r, ini.ScrollbarBg.g, ini.ScrollbarBg.b, ini.ScrollbarBg.a = tonumber(("%.3f"):format(icolors.ScrollbarBg[0])), tonumber(("%.3f"):format(icolors.ScrollbarBg[1])), tonumber(("%.3f"):format(icolors.ScrollbarBg[2])), tonumber(("%.3f"):format(icolors.ScrollbarBg[3]))
                                save()
                                SwitchTheStyle(1)
                            end
                            imgui.Text(u8"Color de la barra derecha:") imgui.SameLine()
                            imgui.SetCursorPosX(240)
                            if imgui.ColorEdit4("##ScrollbarGrab", icolors.ScrollbarGrab, imgui.ColorEditFlags.AlphaBar + imgui.ColorEditFlags.NoInputs) then
                                ini.ScrollbarGrab.r, ini.ScrollbarGrab.g, ini.ScrollbarGrab.b, ini.ScrollbarGrab.a = tonumber(("%.3f"):format(icolors.ScrollbarGrab[0])), tonumber(("%.3f"):format(icolors.ScrollbarGrab[1])), tonumber(("%.3f"):format(icolors.ScrollbarGrab[2])), tonumber(("%.3f"):format(icolors.ScrollbarGrab[3]))
                                save()
                                SwitchTheStyle(1)
                            end
                            imgui.Text(u8"Barra derecha al pasar el mouse:") imgui.SameLine()
                            imgui.SetCursorPosX(240)
                            if imgui.ColorEdit4("##ScrollbarGrabHovered", icolors.ScrollbarGrabHovered, imgui.ColorEditFlags.AlphaBar + imgui.ColorEditFlags.NoInputs) then
                                ini.ScrollbarGrabHovered.r, ini.ScrollbarGrabHovered.g, ini.ScrollbarGrabHovered.b, ini.ScrollbarGrabHovered.a = tonumber(("%.3f"):format(icolors.ScrollbarGrabHovered[0])), tonumber(("%.3f"):format(icolors.ScrollbarGrabHovered[1])), tonumber(("%.3f"):format(icolors.ScrollbarGrabHovered[2])), tonumber(("%.3f"):format(icolors.ScrollbarGrabHovered[3]))
                                save()
                                SwitchTheStyle(1)
                            end
                            imgui.Text(u8"Color de la barra derecha activa:") imgui.SameLine()
                            imgui.SetCursorPosX(240)
                            if imgui.ColorEdit4("##ScrollbarGrabActive", icolors.ScrollbarGrabActive, imgui.ColorEditFlags.AlphaBar + imgui.ColorEditFlags.NoInputs) then
                                ini.ScrollbarGrabActive.r, ini.ScrollbarGrabActive.g, ini.ScrollbarGrabActive.b, ini.ScrollbarGrabActive.a = tonumber(("%.3f"):format(icolors.ScrollbarGrabActive[0])), tonumber(("%.3f"):format(icolors.ScrollbarGrabActive[1])), tonumber(("%.3f"):format(icolors.ScrollbarGrabActive[2])), tonumber(("%.3f"):format(icolors.ScrollbarGrabActive[3]))
                                save()
                                SwitchTheStyle(1)
                            end
                            imgui.Text(u8"Color del logotipo:") imgui.SameLine()
                            imgui.SetCursorPosX(240)
                            if imgui.ColorEdit4("##LogoColor", icolors.LogoColor, imgui.ColorEditFlags.AlphaBar + imgui.ColorEditFlags.NoInputs) then
                                ini.logocolor.r, ini.logocolor.g, ini.logocolor.b, ini.logocolor.a = tonumber(("%.3f"):format(icolors.LogoColor[0])), tonumber(("%.3f"):format(icolors.LogoColor[1])), tonumber(("%.3f"):format(icolors.LogoColor[2])), tonumber(("%.3f"):format(icolors.LogoColor[3]))
                                save()
                                SwitchTheStyle(1)
                            end
                        
                        end
                        
                        
                    elseif tab[0] == 2 then
                        for k, v in orderedPairs(imguiCheckboxesFixesAndPatches) do
                            if imgui.Checkbox(k, v.var) then
                                ini.settings[v.cfg] = v.var[0]
                                save()
                                if v.fnc ~= "_" then
                                    gotofunc(v.fnc)
                                end
                            end
                        end
                        if imgui.Checkbox(u8"Corrección del ciclo de tiempo para el posprocesamiento deshabilitado", checkboxes.fixtimecyc) then
                            ini.fixtimecyc.active = checkboxes.fixtimecyc[0]
                            save()
                            gotofunc("FixTimecyc")
                        end
                        if ini.fixtimecyc.active then
                            if imgui.ColorEdit3(u8"Ambiente mundial", icolors.wamb) then
                                ini.fixtimecyc.worldambientR, ini.fixtimecyc.worldambientG, ini.fixtimecyc.worldambientB = ("%.3f"):format(icolors.wamb[0]), ("%.3f"):format(icolors.wamb[1]), ("%.3f"):format(icolors.wamb[2])
                                save()
                                gotofunc("FixTimecyc")
                            end
                            imgui.Text(u8"Brillo todo ambiente:")
                            imgui.PushItemWidth(625)
                            if imgui.SliderFloat(u8"##AllAmbient", sliders.allambient, 0.000, 1.000, "%.3f") then
                                ini.fixtimecyc.allambient = ("%.3f"):format(sliders.allambient[0])
                                save()
                                gotofunc("FixTimecyc")
                            end
                            imgui.Text(u8"Brillo ambiente del objeto:")
                            if imgui.SliderFloat(u8"##ObjAmbient", sliders.objambient, 0.000, 1.000, "%.3f") then
                                ini.fixtimecyc.objambient = ("%.3f"):format(sliders.objambient[0])
                                save()
                                gotofunc("FixTimecyc")
                            end
                            imgui.PopItemWidth()
                        end
                        
                        
                    elseif tab[0] == 3 then
                        imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.0, 0.0, 0.0, 0.0))
                        imgui.SetCursorPosX(imgui.GetCursorPosX() -10)
                        imgui.BeginChild("##leftmenudd", imgui.ImVec2(170, 465), false)
                            imgui.CustomSelectable(dabs, dab, imgui.ImVec2(185, 30))
                        imgui.EndChild()
                        imgui.SameLine()
                        imgui.PushStyleColor(imgui.Col.Border, imgui.GetStyle().Colors[imgui.Col.Button])
                        imgui.SetCursorPosX(imgui.GetCursorPosX() - 5)
                        imgui.BeginChild("##rightmenudd", imgui.ImVec2(545, 465), true)
                        imgui.PopStyleColor(2)
                            if dab[0] == 1 then
                                if not doesFileExist(getGameDirectory()..'\\_CoreGame.asi') then
                                    if imgui.Checkbox(u8"Habilitar la capacidad de cambiar la representación.", checkboxes.givemedist) then
                                        ini.settings.givemedist = not ini.settings.givemedist
                                        save()
                                        gotofunc("GivemeDist")
                                    end
                                    if ini.settings.givemedist then
                                        imgui.PushItemWidth(525)
                                            if imgui.SliderFloat(u8"##Drawdist", sliders.drawdist, 35, 3600, u8"Dibujo básico: %.1f") then
                                                ini.settings.drawdist = ("%.1f"):format(sliders.drawdist[0])
                                                save()
                                                memory.setfloat(12044272, ini.settings.drawdist, true)
                                            end
                                            imgui.SetCursorPosY(imgui.GetCursorPosY()+10)
                                            if imgui.SliderFloat(u8"##drawdistair", sliders.drawdistair, 35, 2000, u8"En el transporte aéreo: %.1f") then
                                                ini.settings.drawdistair = ("%.1f"):format(sliders.drawdistair[0])
                                                save()
                                                if isCharInAnyPlane(PLAYER_PED) or isCharInAnyHeli(PLAYER_PED) then
                                                    if memory.getfloat(12044272, true) ~= ini.settings.drawdistair then
                                                        memory.setfloat(12044272, ini.settings.drawdistair, true)
                                                    end
                                                end
                                            end
                                            imgui.SetCursorPosY(imgui.GetCursorPosY()+10)
                                            if imgui.SliderFloat(u8"##drawdistpara", sliders.drawdistpara, 35, 2000, u8"Al usar un paracaídas: %.1f") then
                                                ini.settings.drawdistpara = ("%.1f"):format(sliders.drawdistpara[0])
                                                save()
                                                if getCurrentCharWeapon(PLAYER_PED) == 46 then
                                                    if memory.getfloat(12044272, true) ~= ini.settings.drawdistpara then
                                                        memory.setfloat(12044272, ini.settings.drawdistpara, true)
                                                    end
                                                end
                                            end
                                            imgui.SetCursorPosY(imgui.GetCursorPosY()+10)
                                            if imgui.SliderFloat(u8"##fog", sliders.fog, -1000, 3600, u8"Rango de niebla: %.1f") then
                                                ini.settings.fog = ("%.1f"):format(sliders.fog[0])
                                                save()
                                                memory.setfloat(13210352, ini.settings.fog, true)
                                            end
                                            
                                        imgui.PopItemWidth()
                                    end
                                end
                                imgui.PushItemWidth(525)
                                imgui.SetCursorPosY(imgui.GetCursorPosY()+10)
                                if imgui.SliderFloat(u8"##lod", sliders.lod, 0, 1900, u8"Rango de lod: %.1f") then
                                    ini.settings.lod = ("%.1f"):format(sliders.lod[0])
                                    save()
                                    gotofunc("LodDist")
                                end
                                imgui.SetCursorPosY(imgui.GetCursorPosY()+20)
                                imgui.Text(u8"Límite de carga del juego (característica experimental)\nValor estándar 1.2:")
                                if imgui.SliderFloat(u8"##lodscale", sliders.lod_scale, 0.900, 4.000, "%.3f") then
                                    ini.settings.lod_scale = ("%.3f"):format(sliders.lod_scale[0])
                                    save()
                                end
                                imgui.SetCursorPosY(imgui.GetCursorPosY()+10)
                                if imgui.SliderFloat(u8"##vehloddist", sliders.vehloddist, 0, 190, u8"Rango de carga del vehículo: %.1f") then
                                    ini.settings.vehloddist = ("%.1f"):format(sliders.vehloddist[0])
                                    save()
                                    gotofunc("SetDistLodVeh")
                                end
                                imgui.SetCursorPosY(imgui.GetCursorPosY()+10)
                                if memory.read(0x86FC29, 4, true) ~= 4194304 then
                                    if tonumber(sliders.nickdistance[0]) > tonumber(memory.getfloat(0x86FC29, true)) then sliders.nickdistance[0] = memory.getfloat(0x86FC29, true) end
                                    if imgui.SliderFloat(u8"##ntgs", sliders.nickdistance, 0, memory.getfloat(0x86FC29, true), u8"Distancia de nombres: %.1f") then
                                        ini.settings.nickdistance = ("%.1f"):format(sliders.nickdistance[0])
                                        save()
                                    end
                                end
                                imgui.PopItemWidth()
                                
                            elseif dab[0] == 2 then
                                if imgui.Checkbox(u8"Habilitar la capacidad de cambiar el rango de visibilidad de los objetos", checkboxes.givemedistobj) then
                                    ini.settings.givemedistobj = not ini.settings.givemedistobj
                                    save()
                                    gotofunc("SetDistObjects")
                                end
                                if ini.settings.givemedistobj then
                                    imgui.PushItemWidth(500)
                                    if imgui.SliderFloat(u8"##dfonars", sliders.distobjects_stolb_fonars, -10.0, 90.0, u8"Distancia de visibilidad de las farolas y postes: %.1f") then
                                        ini.settings.distobjects_stolb_fonars = ("%.1f"):format(sliders.distobjects_stolb_fonars[0])
                                        save()
                                        gotofunc("SetDistObjects")
                                    end
                                    imgui.SetCursorPosY(imgui.GetCursorPosY()+10)
                                    if imgui.SliderFloat(u8"##dmusor", sliders.distobjects_musor, -10.0, 40.0, u8"Distancia de visibilidad de objetos (cajas y otros): %.1f") then
                                        ini.settings.distobjects_musor = ("%.1f"):format(sliders.distobjects_musor[0])
                                        save()
                                        gotofunc("SetDistObjects")
                                    end
                                    imgui.PopItemWidth()
                                end
                            elseif dab[0] == 3 then
                                if imgui.Checkbox(u8"Habilitar la capacidad de cambiar las sombras.", checkboxes.shadowedit) then
                                    ini.settings.shadowedit = not ini.settings.shadowedit
                                    save()
                                    gotofunc("ShadowEdit")
                                end
                                if imgui.Checkbox(u8"Desactiva las sombras del juego por completo", checkboxes.noshadows) then
                                    ini.settings.noshadows = not ini.settings.noshadows
                                    save()
                                    gotofunc("NoShadows")
                                end
                                if imgui.Checkbox(u8"Desactiva la sombra debajo del personaje.", checkboxes.pedshadows) then
                                    ini.settings.pedshadows = not ini.settings.pedshadows
                                    save()
                                    gotofunc("NoShadows")
                                end
                                if imgui.Checkbox(u8"Desactiva la sombra debajo del transporte.", checkboxes.vehshadows) then
                                    ini.settings.vehshadows = not ini.settings.vehshadows
                                    save()
                                    gotofunc("NoShadows")
                                end
                                if imgui.Checkbox(u8"Desactiva la sombra debajo de los pilares.", checkboxes.poleshadows) then
                                    ini.settings.poleshadows = not ini.settings.poleshadows
                                    save()
                                    gotofunc("NoShadows")
                                end
                                if imgui.Checkbox(u8"Desactiva las sombras en configuraciones de gráficos altas", checkboxes.maxshadows) then
                                    ini.settings.maxshadows = not ini.settings.maxshadows
                                    save()
                                    gotofunc("NoShadows")
                                end
                                
            
                                if ini.settings.shadowedit then
                                    if not ini.settings.noshadows then
                                    imgui.PushItemWidth(525)
                                        if imgui.SliderInt(u8"##shadowcp", sliders.shadowcp, 0, 255, u8"Sombras básicas: %d") then
                                            ini.settings.shadowcp = sliders.shadowcp[0]
                                            save()
                                            memory.setint32(12043496, ini.settings.shadowcp, true)
                                        end
                                        imgui.SetCursorPosY(imgui.GetCursorPosY()+10)
                                        if imgui.SliderInt(u8"##shadowlight", sliders.shadowlight, 0, 255, u8"Sombras del pilar: %d") then
                                            ini.settings.shadowlight = sliders.shadowlight[0]
                                            save()
                                            memory.setint32(12043500, ini.settings.shadowlight, true)
                                        end
                                    imgui.PopItemWidth()
                                    end
                                end
                            elseif dab[0] == 4 then
                                if imgui.Checkbox(u8"Mostrar mensaje de borrado de memoria", checkboxes.cleaninfo) then
                                    ini.cleaner.cleaninfo = checkboxes.cleaninfo[0]
                                    save()
                                end
                                if imgui.Checkbox(u8"Habilitar borrado automático de memoria", checkboxes.autoclean) then
                                    ini.cleaner.autoclean = not ini.cleaner.autoclean
                                    save()
                                end
                                if ini.cleaner.autoclean then
                                    imgui.PushItemWidth(525)
                                    if imgui.SliderInt(u8"##memlimit", sliders.limitmem, 80, 3000, u8"Límite de borrado automático: %d MB") then
                                        ini.cleaner.limit = sliders.limitmem[0]
                                        save()
                                    end
                                    imgui.PopItemWidth()
                                end
                                if imgui.Button(u8"Limpiar memoria", imgui.ImVec2(150, 25)) then
                                    gotofunc("CleanMemory")
                                end
                            elseif dab[0] == 5 then
                                if imgui.Checkbox(u8"Habilitar etiquetas de nombre personalizadas", checkboxes.custom_nametags) then
                                    ini.custom_nametags.status = checkboxes.custom_nametags[0]
                                    save()
                                    if ini.custom_nametags.status then
                                        nameTags.setState(0)
                                    else
                                        nameTags.setState(1)
                                    end
                                end
                                if ini.custom_nametags.status then
                                    imgui.Text(u8"Nombre de la fuente:")
                                    imgui.SameLine()
                                    imgui.PushItemWidth(120)
                                    imgui.InputText(u8"##cntfn", buffers.cnt_fontname, sizeof(buffers.cnt_fontname))
                                    imgui.PopItemWidth()
                                    imgui.SameLine() imgui.SetCursorPosX(260) if imgui.Button(u8"Aceptar##cnt", imgui.ImVec2(90, 25)) then ini.custom_nametags.fontName = str(buffers.cnt_fontname) save() cntfont() end
                                    imgui.PushItemWidth(235)
                                    if imgui.SliderInt(u8"Tamaño de fuente##cntfontsize", sliders.custom_nametags_fontSize, 5, 30) then
                                        ini.custom_nametags.fontSize = sliders.custom_nametags_fontSize[0]
                                        save()
                                        cntfont()
                                    end
                                    if imgui.SliderInt(u8"Bandera de fuente##cntfontflag", sliders.custom_nametags_fontFlag, 0, 15) then
                                        ini.custom_nametags.fontFlag = sliders.custom_nametags_fontFlag[0]
                                        save()
                                        cntfont()
                                    end
                                    imgui.PopItemWidth()
                                end
                            elseif dab[0] == 6 then
                                imgui.Text(u8"Nota: algunos efectos no se eliminan inmediatamente.\nPara hacerlos desaparecer, debe volver a iniciar el juego.")
                                    imgui.SetCursorPos(imgui.ImVec2(100,60))
                                    imgui.BeginTitleChild(u8"Efectos del transporte:", imgui.ImVec2(340, 460), 0, 100)
                                        for k, v in orderedPairs(imguiCheckboxesVehicleEffectsManager) do
                                            if imgui.Checkbox(k, v.var) then
                                                ini.effects_manager[v.cfg] = v.var[0]
                                                ini.settings[v.cfg] = v.var[0]
                                                save()
                                                gotofunc(v.fnc)
                                            end
                                        end
                                    imgui.EndChild()
                                    imgui.SetCursorPosX(100)
                                    imgui.BeginTitleChild(u8"Efectos de armas:", imgui.ImVec2(340, 190), 0, 120)
                                        for k, v in orderedPairs(imguiCheckboxesWeaponEffectsManager) do
                                            if imgui.Checkbox(k, v.var) then
                                                ini.effects_manager[v.cfg] = v.var[0]
                                                ini.settings[v.cfg] = v.var[0]
                                                save()
                                                gotofunc(v.fnc)
                                            end
                                        end
                                    imgui.EndChild()
                                    imgui.SetCursorPosX(100)
                                    imgui.BeginTitleChild(u8"Efectos del cielo:", imgui.ImVec2(340, 150), 0, 120)
                                    for k, v in orderedPairs(imguiCheckboxesEffectsManagerSky) do
                                        if imgui.Checkbox(k, v.var) then
                                            ini.effects_manager[v.cfg] = v.var[0]
                                            ini.settings[v.cfg] = v.var[0]
                                            save()
                                            gotofunc(v.fnc)
                                        end
                                    end
                                    imgui.EndChild()
                                    imgui.SetCursorPosX(100)
                                    imgui.BeginTitleChild(u8"Otros efectos:", imgui.ImVec2(340, 300), 0, 120)
                                    for k, v in orderedPairs(imguiCheckboxesEffectsManagerOther) do
                                        if imgui.Checkbox(k, v.var) then
                                            ini.effects_manager[v.cfg] = v.var[0]
                                            ini.settings[v.cfg] = v.var[0]
                                            save()
                                            gotofunc(v.fnc)
                                        end
                                    end
                                    imgui.EndChild()
                            elseif dab[0] == 7 then
                                imgui.Text(u8"Información:")
                                imgui.BulletText(u8"Para especificar FPS manualmente, mantenga presionado CTRL y LMB en el control.")
                                imgui.BulletText(u8"El parámetro por encima de 299 será interpretado por el script como SIN LÍMITE.")
                                imgui.PushItemWidth(525)
                                if imgui.SliderInt(u8"##FPS de pie", sliders.pedfps, 5, 300, u8"FPS de pie: %d") then
                                    ini.smart_fps.pedfps = sliders.pedfps[0] save()
                                end
                                imgui.SetCursorPosY(imgui.GetCursorPosY()+10)
                                if imgui.SliderInt(u8"##FPS en coche", sliders.vehfps, 5, 300, u8"FPS en coche: %d") then
                                    ini.smart_fps.vehfps = sliders.vehfps[0] save()
                                end
                                imgui.SetCursorPosY(imgui.GetCursorPosY()+10)
                                if imgui.SliderInt(u8"##FPS en bote", sliders.boatfps, 5, 300, u8"FPS en bote: %d") then
                                    ini.smart_fps.boatfps = sliders.boatfps[0] save()
                                end
                                imgui.SetCursorPosY(imgui.GetCursorPosY()+10)
                                if imgui.SliderInt(u8"##FPS en motos", sliders.motofps, 5, 300, u8"FPS en motos: %d") then
                                    ini.smart_fps.motofps = sliders.motofps[0] save()
                                end
                                imgui.SetCursorPosY(imgui.GetCursorPosY()+10)
                                if imgui.SliderInt(u8"##FPS en bicicletas", sliders.bikefps, 5, 300, u8"FPS en bicicletas: %d") then
                                    ini.smart_fps.bikefps = sliders.bikefps[0] save()
                                end
                                imgui.SetCursorPosY(imgui.GetCursorPosY()+10)
                                if imgui.SliderInt(u8"##FPS mientras nada", sliders.swimfps, 5, 300, u8"FPS mientras nada: %d") then
                                    ini.smart_fps.swimfps = sliders.swimfps[0] save()
                                end
                                imgui.SetCursorPosY(imgui.GetCursorPosY()+10)
                                if imgui.SliderInt(u8"##FPS en helicópteros", sliders.helifps, 5, 300, u8"FPS en helicópteros: %d") then
                                    ini.smart_fps.helifps = sliders.helifps[0] save()
                                end
                                imgui.SetCursorPosY(imgui.GetCursorPosY()+10)
                                if imgui.SliderInt(u8"##FPS en aviones", sliders.planefps, 5, 300, u8"FPS en aviones: %d") then
                                    ini.smart_fps.planefps = sliders.planefps[0] save()
                                end
                                imgui.SetCursorPosY(imgui.GetCursorPosY()+10)
                                if imgui.SliderInt(u8"##sniper", sliders.snipergunfps, 5, 300, u8"FPS con Sniper: %d") then
                                    ini.smart_fps.snipergunfps = sliders.snipergunfps[0] save()
                                end
                                imgui.SetCursorPosY(imgui.GetCursorPosY()+10)
                                if imgui.SliderInt(u8"##spray", sliders.spraygunfps, 5, 300, u8"FPS con Spray: %d") then
                                    ini.smart_fps.spraygunfps = sliders.spraygunfps[0] save()
                                end
                                imgui.PopItemWidth()
                            elseif dab[0] == 8 then
                                if imgui.Checkbox(u8"Sincronizacion vertical (Vsync)", checkboxes.vsync) then
                                    ini.settings.vsync = not ini.settings.vsync
                                    save()
                                    gotofunc("Vsync")
                                end
                                for k, v in orderedPairs(imguiCheckboxesBoostFPS) do
                                    if imgui.Checkbox(k, v.var) then
                                        ini.settings[v.cfg] = v.var[0]
                                        save()
                                        gotofunc(v.fnc)
                                    end
                                end
                            end
                        imgui.EndChild()
                        
                        
                    elseif tab[0] == 4 then
                        imgui.Text(u8"Bienvenido al editor del timecyc.")
                        imgui.Text(u8"Esta característica le permite crear su propio timecyc.")
                        imgui.NewLine()
                        imgui.Text(u8"El timecyc se guarda en la carpeta: "..getWorkingDirectory().."\\gamefixer\\timecyc")
                        imgui.Text(u8"Después de crear el timecyc, el archivo de la carpeta "..getWorkingDirectory().."\\gamefixer\\timecyc\n"..u8"Lo deberá de colocar en la carpeta modloader o en la carpeta data.")
                        imgui.NewLine()
                        imgui.Checkbox(u8"Habilitar el editor de timecyc", checkboxes.timecyc_creator)
                        if checkboxes.timecyc_creator[0] then
                            if not ini.settings.blocktime or not ini.settings.blockweather then
                                imgui.Text(u8"La función no está disponible en este momento.\nActive el bloqueo de clima y hora.")
                            else

                                if ini.settings.gtatime or ini.settings.sync_time then
                                    imgui.Text(u8"La función no está disponible en este momento.\nDeshabilite el bucle de tiempo y la sincronización del tiempo del juego desde la PC.")
                                else
                                    Im_Update()
                                    if ini.fixtimecyc.active then
                                        imgui.Text(u8"Tienes la corrección del ciclo de tiempo activada para el posprocesamiento deshabilitado.\nUsar: "..u8:encode(ini.commands.fixtimecyc)..u8" para deshabilitar.")
                                    end
                                    
                                    
                                    imgui.PushItemWidth(400)
                                    local i = NUMWEATHERS * CTimeCycle.GetCurrentHourTimeId() + CurrWeather[0]
                                
                                    CurrWeather[0] = Im.CurrWeather[0]
                                    NextWeather[0] = Im.NextWeather[0]


                                    if imgui.Combo(u8"clima actual", Im.CurrWeather, weatherchar, #weather) then
                                        CurrWeather[0] = Im.CurrWeather[0]
                                        ini.settings.weather = Im.CurrWeather[0]
                                        save()
                                    end

                                    if imgui.Combo(u8"el próximo clima", Im.NextWeather, weatherchar, #weather) then
                                        NextWeather[0] = Im.NextWeather[0]
                                    end

                                    if imgui.SliderInt(u8"Hora", sliders.hours, 0, 23, "%.0f") then ini.settings.hours = sliders.hours[0] save() gotofunc("SetTime") end

                                    if imgui.SliderInt(u8"minutos", sliders.min, 0, 59, "%.0f") then ini.settings.min = sliders.min[0] save() gotofunc("SetTime") end

                                    if imgui.ColorEdit3(u8"Ambiente", Im.AmbRGB) then
                                        CTimeCycle.m_nAmbientRed[i], CTimeCycle.m_nAmbientGreen[i], CTimeCycle.m_nAmbientBlue[i] = Im.AmbRGB[0] * 255, Im.AmbRGB[1] * 255, Im.AmbRGB[2] * 255
                                    end
                                    
                                    if imgui.ColorEdit3(u8"Iluminación dinámica objetos", Im.AmbObjRGB) then
                                        CTimeCycle.m_nAmbientRed_Obj[i], CTimeCycle.m_nAmbientGreen_Obj[i], CTimeCycle.m_nAmbientBlue_Obj[i] = Im.AmbObjRGB[0] * 255, Im.AmbObjRGB[1] * 255, Im.AmbObjRGB[2] * 255
                                    end
                            
                                    if imgui.ColorEdit3(u8"Cielo arriba", Im.SkyTopRGB) then
                                        CTimeCycle.m_nSkyTopRed[i], CTimeCycle.m_nSkyTopGreen[i], CTimeCycle.m_nSkyTopBlue[i] = Im.SkyTopRGB[0] * 255, Im.SkyTopRGB[1] * 255, Im.SkyTopRGB[2] * 255
                                    end
                            
                                    if imgui.ColorEdit3(u8"Cielo abajo", Im.SkyBottomRGB) then
                                        CTimeCycle.m_nSkyBottomRed[i], CTimeCycle.m_nSkyBottomGreen[i], CTimeCycle.m_nSkyBottomBlue[i] = Im.SkyBottomRGB[0] * 255, Im.SkyBottomRGB[1] * 255, Im.SkyBottomRGB[2] * 255
                                    end
                            
                                    if imgui.ColorEdit3(u8"Disco solar", Im.SunCoreRGB) then
                                        CTimeCycle.m_nSunCoreRed[i], CTimeCycle.m_nSunCoreGreen[i], CTimeCycle.m_nSunCoreBlue[i] = Im.SunCoreRGB[0] * 255, Im.SunCoreRGB[1] * 255, Im.SunCoreRGB[2] * 255
                                    end
                            
                                    if imgui.ColorEdit3(u8"Corona solar", Im.SunCoronaRGB) then
                                        CTimeCycle.m_nSunCoronaRed[i], CTimeCycle.m_nSunCoronaGreen[i], CTimeCycle.m_nSunCoronaBlue[i] = Im.SunCoronaRGB[0] * 255, Im.SunCoronaRGB[1] * 255, Im.SunCoronaRGB[2] * 255
                                    end

                                    if imgui.SliderInt(u8"Tamaño del sol", Im.SunSz, 0, 127) then
                                        CTimeCycle.m_fSunSize[i] = Im.SunSz[0]
                                    end
                            
                                    if imgui.SliderInt(u8"Tamaño de objeto", Im.SpriteSz, 0, 127) then
                                        CTimeCycle.m_fSpriteSize[i] = Im.SpriteSz[0]
                                    end
                            
                                    if imgui.InputInt(u8"Brillo de sprites", Im.SpriteBrght, 1, 10) then
                                        CTimeCycle.m_fSpriteBrightness[i] = Im.SpriteBrght[0]
                                    end
                            
                                    if imgui.SliderInt(u8"Configuración de sombras", Im.ShadowStr, 0, 255) then
                                        CTimeCycle.m_nShadowStrength[i] = Im.ShadowStr[0]
                                    end
                            
                                    if imgui.SliderInt(u8"Claridad de los bordes de las sombras.", Im.PoleShadowStr, 0, 255) then
                                        CTimeCycle.m_nPoleShadowStrength[i] = Im.PoleShadowStr[0]
                                    end
                            
                                    if imgui.SliderInt(u8"Fuerza de la iluminación de los objetos.", Im.LightShadowStrength, 0, 255) then
                                        CTimeCycle.m_nLightShadowStrength[i] = Im.LightShadowStrength[0]
                                    end
                            
                                    if imgui.InputInt(u8"Distancia de los objetos", Im.FarClip, 1, 10) then
                                        CTimeCycle.m_fFarClip[i] = Im.FarClip[0]
                                    end
                            
                                    if imgui.InputInt(u8"Distancia de la niebla", Im.FogStart, 1, 10) then
                                        CTimeCycle.m_fFogStart[i] = Im.FogStart[0]
                                    end
                            
                                    if imgui.SliderInt(u8"Brillo de la luz en la tierra", Im.LightsOnGroundBrightness, 0, 255) then
                                        CTimeCycle.m_fLightsOnGroundBrightness[i] = Im.LightsOnGroundBrightness[0]
                                    end
                            
                                    if imgui.ColorEdit3(u8"Nubes bajas", Im.LowCloudsRGB) then
                                        CTimeCycle.m_nLowCloudsRed[i], CTimeCycle.m_nLowCloudsGreen[i], CTimeCycle.m_nLowCloudsBlue[i] = Im.LowCloudsRGB[0] * 255, Im.LowCloudsRGB[1] * 255, Im.LowCloudsRGB[2] * 255
                                    end
                                    if imgui.ColorEdit3(u8"Nubes superiores", Im.FluffyCloudsBotttomRGB) then
                                        CTimeCycle.m_nFluffyCloudsBottomRed[i], CTimeCycle.m_nFluffyCloudsBottomGreen[i], CTimeCycle.m_nFluffyCloudsBottomBlue[i] = Im.FluffyCloudsBotttomRGB[0] * 255, Im.FluffyCloudsBotttomRGB[1] * 255, Im.FluffyCloudsBotttomRGB[2] * 255
                                    end
                            
                                    if imgui.ColorEdit4(u8"Agua", Im.WaterRGBA, imgui.ColorEditFlags.AlphaBar) then
                                        CTimeCycle.m_fWaterRed[i], CTimeCycle.m_fWaterGreen[i], CTimeCycle.m_fWaterBlue[i], CTimeCycle.m_fWaterAlpha[i] = Im.WaterRGBA[0] * 255, Im.WaterRGBA[1] * 255, Im.WaterRGBA[2] * 255, Im.WaterRGBA[3] * 255
                                    end
                            
                                    if imgui.ColorEdit4("PostFx1", Im.PostFx1RGBA, imgui.ColorEditFlags.AlphaBar) then
                                        CTimeCycle.m_fPostFx1Red[i], CTimeCycle.m_fPostFx1Green[i], CTimeCycle.m_fPostFx1Blue[i], CTimeCycle.m_fPostFx1Alpha[i] = Im.PostFx1RGBA[0] * 255, Im.PostFx1RGBA[1] * 255, Im.PostFx1RGBA[2] * 255, Im.PostFx1RGBA[3] * 255
                                    end
                            
                                    if imgui.ColorEdit4("PostFx2", Im.PostFx2RGBA, imgui.ColorEditFlags.AlphaBar) then
                                        CTimeCycle.m_fPostFx2Red[i], CTimeCycle.m_fPostFx2Green[i], CTimeCycle.m_fPostFx2Blue[i], CTimeCycle.m_fPostFx2Alpha[i] = Im.PostFx2RGBA[0] * 255, Im.PostFx2RGBA[1] * 255, Im.PostFx2RGBA[2] * 255, Im.PostFx2RGBA[3] * 255
                                    end
                            
                                    if imgui.SliderInt(u8"Transparencia en la nube", Im.CloudAlpha, 0, 255) then
                                        CTimeCycle.m_fCloudAlpha[i] = Im.CloudAlpha[0]
                                    end
                            
                                    if imgui.SliderInt(u8"min. intensidad de iluminación", Im.HighLightMinIntensity, 0 ,255) then
                                        CTimeCycle.m_nHighLightMinIntensity[i] = Im.HighLightMinIntensity[0]
                                    end
                            
                                    if imgui.SliderInt(u8"Transparencia de la niebla en el agua", Im.WaterFogAlpha, 0, 255) then
                                        CTimeCycle.m_nWaterFogAlpha[i] = Im.WaterFogAlpha[0]
                                    end

                                    if imgui.SliderInt(u8"Poder de iluminación", Im.DirectionalMult, 0, 255) then
                                        CTimeCycle.m_nDirectionalMult[i] = Im.DirectionalMult[0]
                                    end
                            
                                    if imgui.Button(u8"Guardar timecyc") then
                                        CTimeCycle.SaveToFile("timecyc")
                                        printStringNow("Timecyc created!", 1000)
                                    end
                            
                                    imgui.SameLine()
                            
                                    if imgui.Button(u8"Restablecer timecyc") then
                                        CTimeCycle.Initialise()
                                    end
                                    imgui.PopItemWidth()
                                end
                            end
                        end
                        
                    elseif tab[0] == 5 then
                        imgui.SetCursorPosX(imgui.GetCursorPosX() - 10)
                        imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.0, 0.0, 0.0, 0.0))
                        imgui.BeginChild("##leftmenugg", imgui.ImVec2(160, 430), false)
                            imgui.CustomSelectable(sabs, sab, imgui.ImVec2(180, 25))
                        imgui.EndChild()
                        imgui.SameLine()
                        imgui.SetCursorPosX(imgui.GetCursorPosX() - 5)
                        imgui.PushStyleColor(imgui.Col.Border, imgui.GetStyle().Colors[imgui.Col.Button])
                        imgui.BeginChild("##rightmenugg", imgui.ImVec2(500, 430), true)
                        imgui.PopStyleColor(2)
                            if sab[0] == 1 then
                                if imgui.Checkbox(u8"160 HP Bar", checkboxes.bighpbar) then
                                    ini.settings.bighpbar = not ini.settings.bighpbar
                                    save()
                                    gotofunc("BigHPBar")
                                end
                                if imgui.Checkbox(u8"Habilitar HP en números", checkboxes.hphud) then
                                    ini.hphud.status = checkboxes.hphud[0]
                                    save()
                                end
                                if ini.hphud.status then
                                    if imgui.Checkbox(u8"Habilitar la etiqueta de HP junto a los números", checkboxes.hpt) then
                                        ini.hphud.hptext = checkboxes.hpt[0]
                                        save()
                                    end
                                    imgui.PushItemWidth(425)
                                    if imgui.SliderFloat(u8"##La posición del indicador HP: X", sliders.hpposX, 0.0, 625.0, u8"La posición del indicador HP (X): %.2f") then
                                        ini.hphud.posX = ("%.2f"):format(sliders.hpposX[0])
                                        save()
                                    end
                                    if imgui.SliderFloat(u8"##La posición del indicador HP: Y", sliders.hpposY, 0.0, 440.0, u8"La posición del indicador HP (Y): %.2f") then
                                        ini.hphud.posY = ("%.2f"):format(sliders.hpposY[0])
                                        save()
                                    end
                                    imgui.PopItemWidth()
                                    imgui.PushItemWidth(250)
                                    if imgui.SliderInt(u8"Fuente del indicador HP", sliders.hpfonts, 0, 3) then
                                        ini.hphud.fonts = sliders.hpfonts[0]
                                        save()
                                    end
                                end
                                if imgui.Checkbox(u8"Deshabilitar la barra de HP parpadeante", checkboxes.nohealthflick) then
                                    ini.settings.nohealthflick = not ini.settings.nohealthflick
                                    save()
                                    gotofunc("NoHealthFlick")
                                end
                            elseif sab[0] == 2 then
                                if imgui.Checkbox(u8"Eliminar ceros a la izquierda del dinero", checkboxes.moneyzerofix) then
                                    ini.settings.moneyzerofix = checkboxes.moneyzerofix[0]
                                    save()
                                    gotofunc("MoneyZeroFix")
                                end
                                imgui.Text(u8"Animación de cambiar la cantidad de dinero:")
                                imgui.SameLine()
                                imgui.PushItemWidth(130)
                                if imgui.Combo(u8"##Animación de cambiar la cantidad de dinero", ivar, tmtext, #tbmtext) then
                                    ini.settings.animmoney = ivar[0]
                                    save()
                                    gotofunc("AnimationMoney")
                                end
                                imgui.Hint(u8"Cambia la animación de agregar/disminuir dinero en fino", 0.3)
                                if imgui.Combo(u8"Borde de la fuente del dinero", fontmoneybordervar, fontmoneyborderchar, #fontmoneybordertext) then
                                    ini.settings.fontmoneyborder = fontmoneybordervar[0]
                                    save()
                                    gotofunc("MoneyBorder")
                                end
                                imgui.PopItemWidth()
                            elseif sab[0] == 3 then
                                if imgui.Checkbox(u8"Editor de radar", checkboxes.radarfix) then
                                    ini.settings.radarfix = checkboxes.radarfix[0]
                                    save()
                                    gotofunc("Radarfix")
                                end
                                if checkboxes.radarfix[0] then
                                    imgui.PushItemWidth(430)
                                        if imgui.SliderFloat(u8"##Altura del radar", sliders.radarw, 50, 100, u8"Altura del radar: %0.1f") then
                                            ini.settings.radarWidth = sliders.radarw[0]
                                            save()
                                            gotofunc("Radarfix")
                                        end
                                        
                                        if imgui.SliderFloat(u8"##Ancho de radar", sliders.radarh, 50, 100, u8"Ancho de radar: %0.1f") then
                                            ini.settings.radarHeight = sliders.radarh[0]
                                            save()
                                            gotofunc("Radarfix")
                                        end
                                        if imgui.SliderInt(u8"##Posición del radar X", sliders.radarposx, 20, 555, u8"Posición del radar X: %d") then
                                            ini.settings.radarPosX = sliders.radarposx[0]
                                            save()
                                            gotofunc("Radarfix")
                                        end
                                        if imgui.SliderInt(u8"##Posición del radar Y", sliders.radarposy, 20, 555, u8"Posición del radar Y: %d") then
                                            ini.settings.radarPosY = sliders.radarposy[0]
                                            save()
                                            gotofunc("Radarfix")
                                        end
                                    imgui.PopItemWidth()
                                end
                                
                                if imgui.Checkbox(u8"Desactivar icono norte", checkboxes.radrarnorth) then
                                    ini.settings.radrarnorth = not ini.settings.radrarnorth
                                    save()
                                    gotofunc("RadrarNorth")
                                end
                                if imgui.Checkbox(u8"Iconos reducidos en el radar", checkboxes.smalliconsradar) then
                                    ini.settings.smalliconsradar = not ini.settings.smalliconsradar
                                    save()
                                    gotofunc("SmallIconsRadar")
                                end
                        
                                if ini.settings.smalliconsradar then
                                    imgui.PushItemWidth(425)
                                    if imgui.SliderFloat(u8"##Iconos cuadrados", sliders.quadro_icon_size, 0.5, 3.0, u8"Iconos cuadrados: %0.2f") then
                                        ini.settings.quadro_icon_size = sliders.quadro_icon_size[0]
                                        save()
                                        gotofunc("SmallIconsRadar")
                                    end
                                    if imgui.SliderFloat(u8"##Trazo de iconos cuadrados", sliders.quadro_icon_border, 0.5, 3.0, u8"Trazo de iconos cuadrados: %0.2f") then
                                        ini.settings.quadro_icon_border = sliders.quadro_icon_border[0]
                                        save()
                                        gotofunc("SmallIconsRadar")
                                    end
                                    if imgui.SliderFloat(u8"##Triángulo iconos arriba", sliders.trianglev_icon_size, 0.5, 3.0, u8"Triángulo iconos hacia arriba: %0.2f") then
                                        ini.settings.trianglev_icon_size = sliders.trianglev_icon_size[0]
                                        save()
                                        gotofunc("SmallIconsRadar")
                                    end
                                    if imgui.SliderFloat(u8"##Triángulo trazo de iconos hacia arriba", sliders.trianglev_icon_border, 0.5, 3.0, u8"Triángulo trazo de iconos hacia arriba: %0.2f") then
                                        ini.settings.trianglev_icon_border = sliders.trianglev_icon_border[0]
                                        save()
                                        gotofunc("SmallIconsRadar")
                                    end
                                    if imgui.SliderFloat(u8"##Triángulo iconos hacia abajo", sliders.trianglen_icon_size, 0.5, 3.0, u8"Triángulo iconos hacia abajo: %0.2f") then
                                        ini.settings.trianglen_icon_size = sliders.trianglen_icon_size[0]
                                        save()
                                        gotofunc("SmallIconsRadar")
                                    end
                                    if imgui.SliderFloat(u8"##Triángulo trazo de iconos hacia abajo", sliders.trianglen_icon_border, 0.5, 3.0, u8"Triángulo trazo de iconos hacia abajo: %0.2f") then
                                        ini.settings.trianglen_icon_border = sliders.trianglen_icon_border[0]
                                        save()
                                        gotofunc("SmallIconsRadar")
                                    end
                                    if imgui.SliderFloat(u8"##Icono de jugador", sliders.player_icon_size, 3.0, 10.0, u8"Icono del jugador: %0.2f") then
                                        ini.settings.player_icon_size = sliders.player_icon_size[0]
                                        save()
                                        gotofunc("SmallIconsRadar")
                                    end
                                    if imgui.SliderFloat(u8"##Iconos principales", sliders.osnov_icon, 3.0, 10.0, u8"Iconos principales: %0.2f") then
                                        ini.settings.osnov_icon = sliders.osnov_icon[0]
                                        save()
                                        gotofunc("SmallIconsRadar")
                                    end
                                    imgui.PopItemWidth()
                                end
                            elseif sab[0] == 4 then
                                if imgui.Checkbox(u8"Habilitar imágenes completas en el menú", checkboxes.fullmenuimage) then
                                    ini.settings.fullmenuimage = checkboxes.fullmenuimage[0]
                                    save()
                                    gotofunc("MenuImage")
                                end
                                imgui.PushItemWidth(60)
                                if imgui.InputFloat(u8"Ancho", buffers.fullmenuwidth, 0, 10000, "%0.1f") then
                                    ini.settings.fullmenuwidth = buffers.fullmenuwidth[0]
                                    save()
                                    gotofunc("MenuImage")
                                end
                                imgui.SameLine()
                                if imgui.InputFloat(u8"Altura", buffers.fullmenuheight, 0, 10000, "%0.1f") then
                                    ini.settings.fullmenuheight = buffers.fullmenuheight[0]
                                    save()
                                    gotofunc("MenuImage")
                                end
                                imgui.PopItemWidth()
                                if imgui.Checkbox(u8"Escalado automático de mapas", checkboxes.mapzoom) then 
                                    ini.settings.mapzoom = checkboxes.mapzoom[0]
                                    save()
                                    gotofunc("MapZoom")
                                end
                                imgui.Hint(u8"Activa/desactiva la eliminación automática de mapas en el menú ESC", 0.3)
                                imgui.Text(u8"Escala de distancia del mapa:")
                                if imgui.SliderFloat(u8"##mapzoomvalue", sliders.mapzoomvalue, 280.0, 1000.0, "%.1f") then
                                    if ini.settings.mapzoom then
                                        ini.settings.mapzoomvalue = ("%.1f"):format(sliders.mapzoomvalue[0])
                                        save()
                                        memory.setfloat(5719357, ini.settings.mapzoomvalue, true)
                                    else
                                        memory.setfloat(5719357, 1000.0, true)
                                    end
                                end
                                if imgui.Checkbox(u8"Deshabilitar mensajes de menú (ESC)", checkboxes.helptext) then
                                    ini.settings.helptext = not ini.settings.helptext
                                    save()
                                    gotofunc("HelpText")
                                end
                            elseif sab[0] == 5 then
                                imgui.Text(u8"Punto de mira. Escala X:")
                                imgui.SameLine()
                                
                                imgui.PushItemWidth(40)
                                if imgui.InputInt(u8"##crxvmenu", buffers.vmenu_crx, 0, 1000) then
                                    if buffers.vmenu_crx[0] > 1000 then
                                        buffers.vmenu_crx[0] = 1000
                                    elseif buffers.vmenu_crx[0] < 0 then
                                        buffers.vmenu_crx[0] = 0
                                    end
                                    ini.settings.crosshairX = buffers.vmenu_crx[0]
                                    save()
                                    gotofunc("EditCrosshair")
                                end
                                imgui.PopItemWidth()
                                imgui.SameLine()
                                imgui.Text(u8"Y:")
                                imgui.SameLine()
                                imgui.PushItemWidth(40)
                                if imgui.InputInt(u8"##cryvmenu", buffers.vmenu_cry, 0, 1000) then
                                    if buffers.vmenu_cry[0] > 1000 then
                                        buffers.vmenu_cry[0] = 1000
                                    elseif buffers.vmenu_cry[0] < 0 then
                                        buffers.vmenu_cry[0] = 0
                                    end
                                    ini.settings.crosshairY = buffers.vmenu_cry[0]
                                    save()
                                    gotofunc("EditCrosshair")
                                end
                                imgui.PopItemWidth()
                            elseif sab[0] == 6 then
                                if imgui.Checkbox(u8"Encender", checkboxes.recolorer) then
                                    ini.settings.recolorer = checkboxes.recolorer[0]
                                    save()
                                    gotofunc("Recolorer")
                                end
                                if ini.settings.recolorer then
                                    if imgui.ColorEdit3(u8"##Color de la barra de HP", icolors.RECOLORER_HEALTH, imgui.ColorEditFlags.AlphaBar + imgui.ColorEditFlags.NoInputs) then
                                        ini.RECOLORER_HEALTH.r, ini.RECOLORER_HEALTH.g, ini.RECOLORER_HEALTH.b = tonumber(("%.3f"):format(icolors.RECOLORER_HEALTH[0])), tonumber(("%.3f"):format(icolors.RECOLORER_HEALTH[1])), tonumber(("%.3f"):format(icolors.RECOLORER_HEALTH[2]))
                                        save()
                                        gotofunc("Recolorer")
                                    end
                                    imgui.SameLine() imgui.Text(u8"Color de la barra de salud")
                                    if imgui.ColorEdit3(u8"##Color de la tira de armadura", icolors.RECOLORER_ARMOUR, imgui.ColorEditFlags.AlphaBar + imgui.ColorEditFlags.NoInputs) then
                                        ini.RECOLORER_ARMOUR.r, ini.RECOLORER_ARMOUR.g, ini.RECOLORER_ARMOUR.b = tonumber(("%.3f"):format(icolors.RECOLORER_ARMOUR[0])), tonumber(("%.3f"):format(icolors.RECOLORER_ARMOUR[1])), tonumber(("%.3f"):format(icolors.RECOLORER_ARMOUR[2]))
                                        save()
                                        gotofunc("Recolorer")
                                    end
                                    imgui.SameLine() imgui.Text(u8"Color de la barra de chaleco") 
                                    if imgui.ColorEdit3(u8"##color del dinero", icolors.RECOLORER_MONEY, imgui.ColorEditFlags.AlphaBar + imgui.ColorEditFlags.NoInputs) then
                                        ini.RECOLORER_MONEY.r, ini.RECOLORER_MONEY.g, ini.RECOLORER_MONEY.b = tonumber(("%.3f"):format(icolors.RECOLORER_MONEY[0])), tonumber(("%.3f"):format(icolors.RECOLORER_MONEY[1])), tonumber(("%.3f"):format(icolors.RECOLORER_MONEY[2]))
                                        save()
                                        gotofunc("Recolorer")
                                    end
                                    imgui.SameLine() imgui.Text(u8"Color del dinero") 
                                    if imgui.ColorEdit3(u8"##color de las estrellas", icolors.RECOLORER_STARS, imgui.ColorEditFlags.AlphaBar + imgui.ColorEditFlags.NoInputs) then
                                        ini.RECOLORER_STARS.r, ini.RECOLORER_STARS.g, ini.RECOLORER_STARS.b = tonumber(("%.3f"):format(icolors.RECOLORER_STARS[0])), tonumber(("%.3f"):format(icolors.RECOLORER_STARS[1])), tonumber(("%.3f"):format(icolors.RECOLORER_STARS[2]))
                                        save()
                                        gotofunc("Recolorer")
                                    end
                                    imgui.SameLine() imgui.Text(u8"Color estrella") 
                                    if imgui.ColorEdit3(u8"##Color de munición", icolors.RECOLORER_PATRONS, imgui.ColorEditFlags.AlphaBar + imgui.ColorEditFlags.NoInputs) then
                                        ini.RECOLORER_PATRONS.r, ini.RECOLORER_PATRONS.g, ini.RECOLORER_PATRONS.b = tonumber(("%.3f"):format(icolors.RECOLORER_PATRONS[0])), tonumber(("%.3f"):format(icolors.RECOLORER_PATRONS[1])), tonumber(("%.3f"):format(icolors.RECOLORER_PATRONS[2]))
                                        save()
                                        gotofunc("Recolorer")
                                    end
                                    imgui.SameLine() imgui.Text(u8"Color de munición")
                                    if imgui.ColorEdit3(u8"##color del jugador", icolors.RECOLORER_PLAYERHEALTH, imgui.ColorEditFlags.AlphaBar + imgui.ColorEditFlags.NoInputs) then
                                        ini.RECOLORER_PLAYERHEALTH.r, ini.RECOLORER_PLAYERHEALTH.g, ini.RECOLORER_PLAYERHEALTH.b = tonumber(("%.3f"):format(icolors.RECOLORER_PLAYERHEALTH[0])), tonumber(("%.3f"):format(icolors.RECOLORER_PLAYERHEALTH[1])), tonumber(("%.3f"):format(icolors.RECOLORER_PLAYERHEALTH[2]))
                                        save()
                                        gotofunc("Recolorer")
                                    end
                                    imgui.SameLine() imgui.Text(u8"Color de la barra de HP de otros jugadores")
                                    if imgui.ColorEdit3(u8"##Fondo de jugadores de color xx", icolors.RECOLORER_PLAYERHEALTH2, imgui.ColorEditFlags.AlphaBar + imgui.ColorEditFlags.NoInputs) then
                                        ini.RECOLORER_PLAYERHEALTH2.r, ini.RECOLORER_PLAYERHEALTH2.g, ini.RECOLORER_PLAYERHEALTH2.b = tonumber(("%.3f"):format(icolors.RECOLORER_PLAYERHEALTH2[0])), tonumber(("%.3f"):format(icolors.RECOLORER_PLAYERHEALTH2[1])), tonumber(("%.3f"):format(icolors.RECOLORER_PLAYERHEALTH2[2]))
                                        save()
                                        gotofunc("Recolorer")
                                    end
                                    imgui.SameLine() imgui.Text(u8"Fondo de la barra de HP de otros jugadores")
                                    if imgui.ColorEdit3(u8"##Color de la armadura del jugador", icolors.RECOLORER_PLAYERARMOR, imgui.ColorEditFlags.AlphaBar + imgui.ColorEditFlags.NoInputs) then
                                        ini.RECOLORER_PLAYERARMOR.r, ini.RECOLORER_PLAYERARMOR.g, ini.RECOLORER_PLAYERARMOR.b = tonumber(("%.3f"):format(icolors.RECOLORER_PLAYERARMOR[0])), tonumber(("%.3f"):format(icolors.RECOLORER_PLAYERARMOR[1])), tonumber(("%.3f"):format(icolors.RECOLORER_PLAYERARMOR[2]))
                                        save()
                                        gotofunc("Recolorer")
                                    end
                                    imgui.SameLine() imgui.Text(u8"Color de la barra de chaleco de otros jugadores")
                                    if imgui.ColorEdit3(u8"##Fondo de color de la armadura del jugador", icolors.RECOLORER_PLAYERARMOR2, imgui.ColorEditFlags.AlphaBar + imgui.ColorEditFlags.NoInputs) then
                                        ini.RECOLORER_PLAYERARMOR2.r, ini.RECOLORER_PLAYERARMOR2.g, ini.RECOLORER_PLAYERARMOR2.b = tonumber(("%.3f"):format(icolors.RECOLORER_PLAYERARMOR2[0])), tonumber(("%.3f"):format(icolors.RECOLORER_PLAYERARMOR2[1])), tonumber(("%.3f"):format(icolors.RECOLORER_PLAYERARMOR2[2]))
                                        save()
                                        gotofunc("Recolorer")
                                    end
                                    imgui.SameLine() imgui.Text(u8"Fondo de la barra de chaleco de otros jugadores")
                                end
                                
                            elseif sab[0] == 7 then
                                if imgui.Checkbox(u8"Ocultar chat", checkboxes.showchat) then
                                    ini.settings.showchat = checkboxes.showchat[0]
                                    save()
                                    gotofunc("ShowCHAT")
                                end
                                if imgui.Checkbox(u8"Ocultar HUD", checkboxes.showhud) then
                                    ini.settings.showhud = checkboxes.showhud[0]
                                    save()
                                    gotofunc("ShowHUD")
                                end
                                
                                if imgui.Checkbox(u8"Objetivo en los jugadores", checkboxes.targetblip) then
                                    ini.settings.targetblip = not ini.settings.targetblip
                                    save()
                                    gotofunc("TargetBlip")
                                end
                                imgui.Hint(u8"Enciende/apaga el triángulo sobre los jugadores cuando les apuntas", 0.3)
                            
                                
        
                            end


                        
                        imgui.EndChild()
                        
                        
                        

                        imgui.EndChild()
                    elseif tab[0] == 6 then
                        if imgui.Checkbox(u8"Habilitar Ultímate Genrl", checkboxes.ugenrl_enable) then
                            ini.ugenrl_main.enable = checkboxes.ugenrl_enable[0]
                            if ini.ugenrl_main.enable then
                                if ini.settings.sounds then
                                    ini.settings.sounds = false
                                end
                            else
                                if not ini.settings.sounds then
                                    ini.settings.sounds = true
                                end
                                
                                memory.hex2bin("752D", 0x503D34, 2)
                                callFunction(0x507440, 0, 0)
                                writeMemory(0x507750, 1, 86, true)
                            end
                            save()
                            checkboxes.sounds[0] = ini.settings.sounds
                            gotofunc("NoSounds")
                        end
                        
                        if checkboxes.ugenrl_enable[0] then
                            if imgui.Checkbox(u8"Sonidos de disparos", checkboxes.weapon_checkbox) then
                                ini.ugenrl_main.weapon = checkboxes.weapon_checkbox[0]
                                save()
                            end
                            imgui.SetCursorPos(imgui.ImVec2(221, 15))
                            if imgui.Checkbox(u8"Sonido de golpe del jugador", checkboxes.hit_checkbox) then
                                ini.ugenrl_main.hit = checkboxes.hit_checkbox[0]
                                save()
                            end
                            imgui.SetCursorPosX(221)
                            if imgui.Checkbox(u8"Sonidos de dolor", checkboxes.pain_checkbox) then
                                ini.ugenrl_main.pain = checkboxes.pain_checkbox[0]
                                save()
                            end
                            if checkboxes.weapon_checkbox[0] then
                                imgui.SetCursorPosX(10)
                                imgui.SetCursorPosY(68)
                                if imgui.Checkbox(u8"disparos del jugador", checkboxes.enemyweapon_checkbox) then
                                    ini.ugenrl_main.enemyWeapon = checkboxes.enemyweapon_checkbox[0]
                                    save()
                                end
                            end
                            imgui.SetCursorPos(imgui.ImVec2(221, 73))
                            imgui.PushItemWidth(230)
                            imgui.Text(u8"Modo Ugenrl:")
                            imgui.SameLine()
                            imgui.SetCursorPosY(70)
                            if imgui.Combo(u8"##Modo Ugenrl", gmodevar, gmodechar, #gmodetext) then
                                ini.ugenrl_main.mode = gmodevar[0]
                                save()
                                gotofunc("UgenrlMode")
                            end
                            imgui.Hint(u8"Descripción de los modos:\n1. Alto rendimiento - Deshabilita todos los sonidos del juego porque el método estándar de reproducir sonidos en el juego provoca una gran carga en la CPU. Esto es especialmente notable si los jugadores comienzan a disparar cerca del M4.\n2. Sonidos del juego + Genrl: desactiva solo los sonidos de las armas de fuego en GTA. El guion reproducirá los sonidos de las armas.\n3. Sonidos del juego + hit sound: todos los sonidos del juego permanecen en el juego. Solo escuchara sonidos del hit sound.", 0.3)
                            imgui.PopItemWidth()
                            if ini.ugenrl_main.mode ~= 2 then
                                imgui.SetCursorPos(imgui.ImVec2(15, 115))
                                imgui.BeginTitleChild(u8"Sonido Deagle", imgui.ImVec2(140, 142), 7, 30)
                                    for i, v in ipairs(deagleSounds) do
                                        if selected ~= getNumberSounds(24, deagleSounds) then
                                            selected = getNumberSounds(24, deagleSounds)
                                        end
                                        if imgui.Selectable(tostring(i)..". "..v, selected == i) then
                                            changeSound(24, deagleSounds[i])
                                        end
                                    end
                                imgui.EndChild()
                                imgui.SetCursorPos(imgui.ImVec2(180, 115))
                                imgui.BeginTitleChild(u8"Sonido Shotgun", imgui.ImVec2(140, 142), 7, 30)
                                    for i, v in ipairs(shotgunSounds) do
                                        if selected ~= getNumberSounds(25, shotgunSounds) then
                                            selected = getNumberSounds(25, shotgunSounds)
                                        end
                                        if imgui.Selectable(tostring(i)..". "..v, selected == i) then
                                            changeSound(25, shotgunSounds[i])
                                        end
                                    end
                                imgui.EndChild()
                                imgui.SetCursorPos(imgui.ImVec2(345, 115))
                                imgui.BeginTitleChild(u8"Sonido M4", imgui.ImVec2(140, 142), 7, 40)
                                    for i, v in ipairs(m4Sounds) do
                                        if selected ~= getNumberSounds(31, m4Sounds) then
                                            selected = getNumberSounds(31, m4Sounds)
                                        end
                                        if imgui.Selectable(tostring(i)..". "..v, selected == i) then
                                            changeSound(31, m4Sounds[i])
                                        end
                                    end
                                imgui.EndChild()

                                imgui.SetCursorPos(imgui.ImVec2(510, 115))
                                imgui.BeginTitleChild(u8"Sonido Rifle", imgui.ImVec2(140, 142), 7, 40)
                                    for i, v in ipairs(rifleSounds) do
                                        if selected ~= getNumberSounds(33, rifleSounds) then
                                            selected = getNumberSounds(33, rifleSounds)
                                        end
                                        if imgui.Selectable(tostring(i)..". "..v, selected == i) then
                                            changeSound(33, rifleSounds[i])
                                        end
                                    end
                                imgui.EndChild()

                                imgui.SetCursorPos(imgui.ImVec2(15, 310))
                                imgui.BeginTitleChild(u8"Sonido MP5", imgui.ImVec2(140, 142), 7, 40)
                                    for i, v in ipairs(mp5Sounds) do
                                        if selected ~= getNumberSounds(29, mp5Sounds) then
                                            selected = getNumberSounds(29, mp5Sounds)
                                        end
                                        if imgui.Selectable(tostring(i)..". "..v, selected == i) then
                                            changeSound(29, mp5Sounds[i])
                                        end
                                    end
                                imgui.EndChild()

                                imgui.SetCursorPos(imgui.ImVec2(180, 310))
                                imgui.BeginTitleChild(u8"Sonido UZI", imgui.ImVec2(140, 142), 7, 40)
                                    for i, v in ipairs(uziSounds) do
                                        if selected ~= getNumberSounds(28, uziSounds) then
                                            selected = getNumberSounds(28, uziSounds)
                                        end
                                        if imgui.Selectable(tostring(i)..". "..v, selected == i) then
                                            changeSound(28, uziSounds[i])
                                        end
                                    end
                                imgui.EndChild()

                                imgui.SetCursorPos(imgui.ImVec2(345, 310))
                                imgui.BeginTitleChild(u8"Sonido Pistola 9mm", imgui.ImVec2(140, 142), 7, 20)
                                    for i, v in ipairs(Pistol9mmSounds) do
                                        if selected ~= getNumberSounds(22, Pistol9mmSounds) then
                                            selected = getNumberSounds(22, Pistol9mmSounds)
                                        end
                                        if imgui.Selectable(tostring(i)..". "..v, selected == i) then
                                            changeSound(22, Pistol9mmSounds[i])
                                        end
                                    end
                                imgui.EndChild()

                                imgui.SetCursorPos(imgui.ImVec2(510, 310))
                                imgui.BeginTitleChild(u8"Sonido Minigun", imgui.ImVec2(140, 142), 7, 20)
                                    for i, v in ipairs(MinigunSounds) do
                                        if selected ~= getNumberSounds(38, MinigunSounds) then
                                            selected = getNumberSounds(38, MinigunSounds)
                                        end
                                        if imgui.Selectable(tostring(i)..". "..v, selected == i) then
                                            changeSound(38, MinigunSounds[i])
                                        end
                                    end
                                imgui.EndChild()

                                imgui.SetCursorPos(imgui.ImVec2(15, 505))
                                imgui.BeginTitleChild(u8"Sonido AK-47", imgui.ImVec2(140, 142), 7, 35)
                                    for i, v in ipairs(AKSounds) do
                                        if selected ~= getNumberSounds(30, AKSounds) then
                                            selected = getNumberSounds(30, AKSounds)
                                        end
                                        if imgui.Selectable(tostring(i)..". "..v, selected == i) then
                                            changeSound(30, AKSounds[i])
                                        end
                                    end
                                imgui.EndChild()

                                imgui.SetCursorPos(imgui.ImVec2(180, 505))
                                imgui.BeginTitleChild(u8"Sonido RPG", imgui.ImVec2(140, 142), 7, 40)
                                    for i, v in ipairs(RPGSounds) do
                                        if selected ~= getNumberSounds(35, RPGSounds) then
                                            selected = getNumberSounds(35, RPGSounds)
                                        end
                                        if imgui.Selectable(tostring(i)..". "..v, selected == i) then
                                            changeSound(35, RPGSounds[i])
                                        end
                                    end
                                imgui.EndChild()

                                imgui.SetCursorPos(imgui.ImVec2(345, 505))
                                imgui.BeginTitleChild(u8"Sonido Sniper", imgui.ImVec2(140, 142), 7, 35)
                                    for i, v in ipairs(SniperSounds) do
                                        if selected ~= getNumberSounds(34, SniperSounds) then
                                            selected = getNumberSounds(34, SniperSounds)
                                        end
                                        if imgui.Selectable(tostring(i)..". "..v, selected == i) then
                                            changeSound(34, SniperSounds[i])
                                        end
                                    end
                                imgui.EndChild()
                                
                                imgui.SetCursorPos(imgui.ImVec2(510, 505))
                                imgui.BeginTitleChild(u8"Sonido hitsound", imgui.ImVec2(140, 142), 7, 20)
                                    for i, v in ipairs(hitSounds) do
                                        if selected ~= getNumberSounds("hit", hitSounds) then
                                            selected = getNumberSounds("hit", hitSounds)
                                        end
                                        if imgui.Selectable(tostring(i)..". "..v, selected == i) then
                                            changeSound("hit", hitSounds[i])
                                        end
                                    end
                                imgui.EndChild()

                                imgui.SetCursorPos(imgui.ImVec2(510, 700))
                                imgui.BeginTitleChild(u8"Sonido de dolor", imgui.ImVec2(140, 142), 7, 40)
                                    for i, v in ipairs(painSounds) do
                                        if selected ~= getNumberSounds("pain", painSounds) then
                                            selected = getNumberSounds("pain", painSounds)
                                        end
                                        if imgui.Selectable(tostring(i)..". "..v, selected == i) then
                                            changeSound("pain", painSounds[i])
                                        end
                                    end
                                imgui.EndChild()
                                imgui.SetCursorPos(imgui.ImVec2(510, 900))
                                imgui.BeginTitleChild(u8"Sonido Explosión", imgui.ImVec2(140, 142), 7, 30)
                                    for i, v in ipairs(explSounds) do
                                        if selected ~= getNumberSounds("expl", explSounds) then
                                            selected = getNumberSounds("expl", explSounds)
                                        end
                                        if imgui.Selectable(tostring(i)..". "..v, selected == i) then
                                            changeSound("expl", explSounds[i])
                                        end
                                    end
                                imgui.EndChild()

                                imgui.PushItemWidth(280)
                                imgui.SetCursorPos(imgui.ImVec2(15, 700))
                                if imgui.SliderFloat(u8"##Volumen de disparo##1", sliders.weapon_volume_slider, 0.00, 1.00, u8"Volumen de disparo: %.2f") then
                                    ini.ugenrl_volume.weapon = ("%.2f"):format(sliders.weapon_volume_slider[0])
                                    save()
                                end
                                imgui.SetCursorPos(imgui.ImVec2(15, 740))
                                if imgui.SliderFloat(u8"##Volumen de hitsound##1", sliders.hit_volume_slider, 0.00, 1.00, u8"Volumen de hitsound: %.2f") then
                                    ini.ugenrl_volume.hit = ("%.2f"):format(sliders.hit_volume_slider[0])
                                    save()
                                end
                                imgui.SetCursorPos(imgui.ImVec2(15, 780))
                                if imgui.SliderFloat(u8"##volumen de dolor##1", sliders.pain_volume_slider, 0.00, 1.00, u8"Volumen de dolor: %.2f") then
                                    ini.ugenrl_volume.pain = ("%.2f"):format(sliders.pain_volume_slider[0]) 
                                    save()
                                end
                                imgui.SetCursorPos(imgui.ImVec2(15, 820))
                                if imgui.SliderInt(u8"##Rango de sonido", sliders.enemyweapon_dist, 0, 100, u8"Rango de sonido: %d") then
                                    ini.ugenrl_main.enemyWeaponDist = sliders.enemyweapon_dist[0]
                                    save()
                                end
                                imgui.SetCursorPos(imgui.ImVec2(15, 860))
                                if imgui.SliderFloat(u8"##Volumen de explosiones##1", sliders.expl_volume_slider, 0.00, 1.00, u8"Volumen de explosiones: %.2f") then
                                    ini.ugenrl_volume.expl = ("%.2f"):format(sliders.expl_volume_slider[0]) 
                                    save()
                                end
                                imgui.PopItemWidth()
                            else
                                imgui.SetCursorPos(imgui.ImVec2(10, 120))
                                imgui.BeginTitleChild(u8"Sonido hitsound", imgui.ImVec2(140, 142), 7, 20)
                                    for i, v in ipairs(hitSounds) do
                                        if selected ~= getNumberSounds("hit", hitSounds) then
                                            selected = getNumberSounds("hit", hitSounds)
                                        end
                                        if imgui.Selectable(tostring(i)..". "..v, selected == i) then
                                            changeSound("hit", hitSounds[i])
                                        end
                                    end
                                imgui.EndChild()
                                imgui.PushItemWidth(220)
                                imgui.SetCursorPos(imgui.ImVec2(180, 120))
                                if imgui.SliderFloat(u8"Volumen de hitsound##1", sliders.hit_volume_slider, 0.00, 1.00, "%.2f") then
                                    ini.ugenrl_volume.hit = ("%.2f"):format(sliders.hit_volume_slider[0])
                                    save()
                                end
                            end
                        end
                        if ini.ugenrl_main.enable then
                            if ini.ugenrl_main.mode == 2 then
                                imgui.SetCursorPosY(300)
                            else
                            imgui.SetCursorPos(imgui.ImVec2(320, 700))
                            end
                        end
                        imgui.BeginGroup()
                        if imgui.Checkbox(u8"Activar Radio en vehículos", checkboxes.noradio) then
                            ini.settings.noradio = not ini.settings.noradio
                            save()
                            gotofunc("NoRadio")
                        end
                        if not ini.ugenrl_main.enable and imgui.Checkbox(u8"Activar sonidos del juego", checkboxes.sounds) then
                            ini.settings.sounds = not ini.settings.sounds
                            if ini.ugenrl_main.enable then ini.settings.sounds = false checkboxes.sounds[0] = ini.settings.sounds end
                            save()
                            gotofunc("NoSounds")
                        end
                        if imgui.Checkbox(u8"Activar música en interiores", checkboxes.intmusic) then
                            ini.settings.intmusic = not ini.settings.intmusic
                            save()
                            gotofunc("InteriorMusic")
                        end
                        if imgui.Checkbox(u8"Activar sonidos del servidor (Audiostream)", checkboxes.audiostream) then
                            ini.settings.audiostream = not ini.settings.audiostream
                            save()
                            gotofunc("AudioStream")
                        end
                        imgui.EndGroup()
                    elseif tab[0] == 7 then
                        imgui.SetCursorPosX(150)
                        imgui.NewInputText('##SearchBar', buffers.search_cmd, 300, u8'Busqueda de lista', 2)
                        imgui.Separator()
                        imgui.PushItemWidth(130)
                        for k, v in orderedPairs(imguiInputsCmdEditor) do
                            if str(buffers.search_cmd) ~= "" then
                                if k:find(str(buffers.search_cmd)) or str(v.var):find(str(buffers.search_cmd)) then
                                    if imgui.InputText(k, v.var, sizeof(v.var)) then
                                        local cmd = string.lower(str(v.var))
                                        ini.commands[v.cfg] = cmd
                                        save()
                                    end
                                end
                            else
                                if imgui.InputText(k, v.var, sizeof(v.var)) then
                                    local cmd = string.lower(str(v.var))
                                    ini.commands[v.cfg] = cmd
                                    save()
                                end
                            end
                        end
                        imgui.PopItemWidth()
                    end
                    imgui.PopFont()
                imgui.EndChild()
            imgui.EndChild()
        imgui.End()
        imgui.PopStyleVar()
    end
)

--==========================================[ Custom NameTags ] ========================================
function explode_argb(argb)
    local a = bit.band(bit.rshift(argb, 24), 0xFF)
    local r = bit.band(bit.rshift(argb, 16), 0xFF)
    local g = bit.band(bit.rshift(argb, 8), 0xFF)
    local b = bit.band(argb, 0xFF)
    return a, r, g, b
end

function join_argb(a, r, g, b)
    local argb = b  -- b
    argb = bit.bor(argb, bit.lshift(g, 8))  -- g
    argb = bit.bor(argb, bit.lshift(r, 16)) -- r
    argb = bit.bor(argb, bit.lshift(a, 24)) -- a
    return argb
end

function cntfont()
    CNTrenderFont = renderCreateFont(ini.custom_nametags.fontName, ini.custom_nametags.fontSize, ini.custom_nametags.fontFlag)
end
--===============================================================================================================================================

function get_samp_version()
    if samp_base == nil or samp_base == 0 then 
        samp_base = getModuleHandle("samp.dll") 
    end 

    if samp_base ~= 0 then 
        local e_lfanew = ffi.cast("long*", samp_base + 60)[0] 
        local nt_header = samp_base + e_lfanew 
        local entry_point_addr = ffi.cast("unsigned int*", nt_header + 40)[0] 
        local samp_version = {
            [0x31DF13] = "r1",
            [0x3195DD] = "r2",
            [0xCC4D0] = "r3",
            [0xCBCB0] = "r4",
            [0xFDB60] = "dl"
        }
        return samp_version[entry_point_addr] or "unknown"
    end 

    return "unknown" 
end


----------------------------------- [ugenrl] ------------------------------------------------------------
function getListOfSounds(name)
    local soundFiles = {}
    for file in lfs.dir(soundsDir) do
        if file:match(name) then
            table.insert(soundFiles, file)
        end
    end
    return soundFiles
end

function loadSounds()
	deagleSounds = getListOfSounds('Deagle')
	shotgunSounds = getListOfSounds('Shotgun')
    rifleSounds = getListOfSounds('Rifle')
	m4Sounds = getListOfSounds('M4')
    mp5Sounds = getListOfSounds('MP5')
    uziSounds = getListOfSounds('Uzi')
    Pistol9mmSounds = getListOfSounds('Pistol9mm')
    MinigunSounds = getListOfSounds('Minigun')
    AKSounds = getListOfSounds('AK')
    RPGSounds = getListOfSounds('RPG')
    SniperSounds = getListOfSounds('Sniper')
	hitSounds = getListOfSounds('Bell')
	painSounds = getListOfSounds('Pain')
    explSounds = getListOfSounds('Explosion')
end

function changeSound(id, name)
	playSound(name, ini.ugenrl_volume.weapon)
	ini.ugenrl_sounds[id] = name
	save()
end

function getNumberSounds(id, name)
    for i, v in ipairs(name) do
        if v == ini.ugenrl_sounds[id] then
            n = i
        end
    end
    return n
end

function playSound(soundFile, soundVol, charHandle)
	if not soundFile or not doesFileExist(soundsDir..soundFile) then return false end
	if audio then collectgarbage() end
	if charHandle == nil then
		audio = loadAudioStream(soundsDir..soundFile)
    elseif charHandle ~= nil then
		audio = load3dAudioStream(soundsDir..soundFile) 
		setPlay3dAudioStreamAtChar(audio, charHandle)
	end
	setAudioStreamVolume(audio, soundVol)
	setAudioStreamState(audio, 1)
	clearSound(audio)
end

function clearSound(audio)
	lua_thread.create(function()
		while getAudioStreamState(audio) == 1 do wait(50) end
		collectgarbage()
	end)
end

function isExpl()
    return readMemory(0xC88950 + 0x28, 1, true) == 1
end


local sampev = require 'samp.events'

function sampev.onSendCommand(cmd)
    cmd = string.lower(cmd)

    if cmd:find("^"..ini.commands.openmenu.."$") then
        gotofunc("OpenMenu")
        return false
    elseif cmd:find("^"..ini.commands.tws.."$") then
        gotofunc("OpenTws")
        return false
    elseif cmd:find("^/gfunload$") then
        sampAddChatMessage(script_name.." {FFFFFF}Guión cargado correctamente! Para recargar el Guión use: {dc4747}CTRL + R", 0x73b461)
        thisScript():unload()
        return false
    elseif cmd:find("^"..ini.commands.settime.." .+") or cmd:find("^"..ini.commands.settime.."$") then
        local hours = cmd:match(ini.commands.settime.." (%d+)")
        local min = cmd:match(ini.commands.settime.." %d+%s(%d+)")
        if min == nil then min = 0 end
        hours = tonumber(hours)
        min = tonumber(min)
        if ini.settings.blocktime then
            if type(hours) ~= 'number' or hours < 0 or hours > 23 or type(min) ~= 'number' or min < 0 or min > 59 then
                sampAddChatMessage(script_name.." {FFFFFF}Usar: {dc4747}"..ini.commands.settime.." [0-23 - ÷ Hora] [0-59 - minutos]", 0x73b461)
                sampAddChatMessage(script_name.." {FFFFFF}Parámetro actual: {dc4747}"..ini.settings.hours..":"..("%02d"):format(ini.settings.min), 0x73b461)
            else
                ini.settings.hours = hours
                ini.settings.min = min
                save()
                sliders.hours[0] = ini.settings.hours
                sliders.min[0] = ini.settings.min
                gotofunc("SetTime")
                sampAddChatMessage(script_name.." {FFFFFF}Tiempo establecido: {dc4747}"..ini.settings.hours..":"..("%02d"):format(ini.settings.min), 0x73b461)
            end
        else
            sampAddChatMessage(script_name.." {FFFFFF}Para bloquear al cambio de hora por el servidor, use: {dc4747}"..ini.commands.blockservertime, 0x73b461)
        end
        return false
    elseif cmd:find("^"..ini.commands.setweather.." .+") or cmd:find("^"..ini.commands.setweather.."$") then
        local weather = cmd:match(ini.commands.setweather.."(.+)")
        weather = tonumber(weather)
        if ini.settings.blockweather then
            if type(weather) ~= 'number' or weather < 0 or weather > 45 then
                sampAddChatMessage(script_name.." {FFFFFF}Usar: {dc4747}"..ini.commands.setweather.." [0-45]", 0x73b461)
                sampAddChatMessage(script_name.." {FFFFFF}Parámetro actual: {dc4747}"..ini.settings.weather, 0x73b461)
            else
                ini.settings.weather = weather
                save()
                sliders.weather[0] = ini.settings.weather
                gotofunc("SetWeather")
                sampAddChatMessage(script_name.." {FFFFFF}El clima esta listo: {dc4747}"..ini.settings.weather, 0x73b461)
            end
        else
            sampAddChatMessage(script_name.." {FFFFFF}Para bloquear al cambio de clima por el servidor, use: {dc4747}"..ini.commands.blockserverweather, 0x73b461)
        end
        return false
    elseif cmd:find("^"..ini.commands.blockservertime.."$") then
        ini.settings.blocktime = not ini.settings.blocktime
        save()
        checkboxes.blocktime[0] = ini.settings.blocktime
        gotofunc("BlockTime")
        gotofunc("SetTime")
        sampAddChatMessage(ini.settings.blocktime and script_name..' {FFFFFF}Ahora el servidor {dc4747}no puede {FFFFFF} cambiar tu hora.' or script_name..' {FFFFFF}Ahora el servidor {73b461}puede {FFFFFF} cambiar tu hora.', 0x73b461)
        return false
    elseif cmd:find("^"..ini.commands.blockserverweather.."$") then
        ini.settings.blockweather = not ini.settings.blockweather
        save()
        checkboxes.blockweather[0] = ini.settings.blockweather
        gotofunc("BlockWeather")
        gotofunc("SetWeather")
        sampAddChatMessage(ini.settings.blockweather and script_name..' {FFFFFF}Ahora el servidor {dc4747}no puede {FFFFFF} cambiar tu clima.' or script_name..' {FFFFFF}Ahora el servidor {73b461}puede {FFFFFF} cambiar tu clima.', 0x73b461)
        return false
    elseif cmd:find("^"..ini.commands.givemedist.."$") then
        ini.settings.givemedist = not ini.settings.givemedist
        sampAddChatMessage(ini.settings.givemedist and script_name..' {FFFFFF}Posibilidad de cambiar la distancia de dibujado {73b461}activado' or script_name..' {FFFFFF}Posibilidad de cambiar la distancia de dibujado {dc4747}apagado', 0x73b461)
        save()
        gotofunc("GivemeDist")
        return false
    elseif cmd:find("^"..ini.commands.givemedistobj.."$") then
        ini.settings.givemedistobj = not ini.settings.givemedistobj
        sampAddChatMessage(ini.settings.givemedistobj and script_name..' {FFFFFF}Posibilidad de cambiar la distancia de objetos {dc4747}activado' or script_name..' {FFFFFF}Posibilidad de cambiar la distancia de objetos {73b461}apagado', 0x73b461)
        save()
        gotofunc("SetDistObjects")
        return false
    elseif cmd:find("^"..ini.commands.drawdistance.." .+") or cmd:find("^"..ini.commands.drawdistance.."$") then
        local drawdist = cmd:match(ini.commands.drawdistance.." (.+)")
        drawdist = tonumber(drawdist)
        if ini.settings.givemedist then  
            if type(drawdist) ~= 'number' or drawdist > 2000 or drawdist < 35 then
                sampAddChatMessage(script_name.." {FFFFFF}Usar: {dc4747}"..ini.commands.drawdistance.." [35-2000]", 0x73b461)
                sampAddChatMessage(script_name.." {FFFFFF}Parámetro actual: {dc4747}"..ini.settings.drawdist, 0x73b461)
            else
                ini.settings.drawdist = ("%.1f"):format(drawdist)
                save()
                sliders.drawdist[0] = tonumber(ini.settings.drawdist)
                sampAddChatMessage(script_name.." {FFFFFF}Conjunto de rango: {dc4747}"..ini.settings.drawdist, 0x73b461)
            end
        else
            sampAddChatMessage(script_name.." {FFFFFF}Has desactivado la posibilidad de cambiar el dibujado., activar¸: {dc4747}"..ini.commands.givemedist, 0x73b461)
        end
        return false
    elseif cmd:find("^"..ini.commands.drawdistanceair.." .+") or cmd:find("^"..ini.commands.drawdistanceair.."$") then
        local drawdistair = cmd:match(ini.commands.drawdistanceair.." (.+)")
        drawdistair = tonumber(drawdistair)
        if ini.settings.givemedist then
            if type(drawdistair) ~= 'number' or drawdistair > 2000 or drawdistair < 35 then
                sampAddChatMessage(script_name.." {FFFFFF}Usar: {dc4747}"..ini.commands.drawdistanceair.." [35-2000]", 0x73b461)
                sampAddChatMessage(script_name.." {FFFFFF}Parámetro actual: {dc4747}"..ini.settings.drawdistair, 0x73b461)
            else
                ini.settings.drawdistair = ("%.1f"):format(drawdistair)
                save()
                sliders.drawdistair[0] = tonumber(ini.settings.drawdistair)
                sampAddChatMessage(script_name.." {FFFFFF}La distancia de dibujo en el transporte aéreo se establece en: {dc4747}"..ini.settings.drawdistair, 0x73b461)
            end
        else
            sampAddChatMessage(script_name.." {FFFFFF}Ha desactivado la posibilidad de cambiar la distancia de dibujado en el transporte aéreo, activar¸: {dc4747}"..ini.commands.givemedist, 0x73b461)
        end
        return false
    elseif cmd:find("^"..ini.commands.drawdistancepara.." .+") or cmd:find("^"..ini.commands.drawdistancepara.."$") then
        local drawdistpara = cmd:match(ini.commands.drawdistancepara.." (.+)")
        drawdistpara = tonumber(drawdistpara)
        if ini.settings.givemedist then
            if type(drawdistpara) ~= 'number' or drawdistpara > 2000 or drawdistpara < 35 then
                sampAddChatMessage(script_name.." {FFFFFF}Usar: {dc4747}"..ini.commands.drawdistancepara.." [35-2000]", 0x73b461)
                sampAddChatMessage(script_name.." {FFFFFF}Parámetro actual: {dc4747}"..ini.settings.drawdistpara, 0x73b461)
            else
                ini.settings.drawdistpara = ("%.1f"):format(drawdistpara)
                save()
                sliders.drawdistpara[0] = tonumber(ini.settings.drawdistpara)
                sampAddChatMessage(script_name.." {FFFFFF}La distancia de dibujo al usar el paracaídas se establece en: {dc4747}"..ini.settings.drawdistpara, 0x73b461)
            end
        else
            sampAddChatMessage(script_name.." {FFFFFF}Ha desactivado la posibilidad de cambiar la distancia de dibujado con paracaídas, activar¸: {dc4747}"..ini.commands.givemedist, 0x73b461)
        end
        return false
    elseif cmd:find("^"..ini.commands.fogdistance.." .+") or cmd:find("^"..ini.commands.fogdistance.."$") then
        local fogdist = cmd:match(ini.commands.fogdistance.." (.+)")
        fogdist = tonumber(fogdist)
        if ini.settings.givemedist then
            if type(fogdist) ~= 'number' or fogdist > 2000 or fogdist < -1000 then
                sampAddChatMessage(script_name.." {FFFFFF}Usar: {dc4747}"..ini.commands.fogdistance.." [-1000 - 2000]", 0x73b461)
                sampAddChatMessage(script_name.." {FFFFFF}Parámetro actual: {dc4747}"..ini.settings.fog, 0x73b461)
            else
                ini.settings.fog = ("%.1f"):format(fogdist)
                save()
                sliders.fog[0] = tonumber(ini.settings.fog)
                memory.setfloat(13210352, ini.settings.fog, true)
                sampAddChatMessage(script_name.." {FFFFFF}La distancia de la niebla se establece en: {dc4747}"..ini.settings.fog, 0x73b461)
            end
        else
            sampAddChatMessage(script_name.." {FFFFFF}Ha desactivado la posibilidad de cambiar la distancia de la niebla, activar¸: {dc4747}"..ini.commands.givemedist, 0x73b461)
        end
        return false
    elseif cmd:find("^"..ini.commands.loddistance.." .+") or cmd:find("^"..ini.commands.loddistance.."$") then
        local loddist = cmd:match(ini.commands.loddistance.." (.+)")
        loddist = tonumber(loddist)
        if ini.settings.givemedist then
            if type(loddist) ~= 'number' or loddist > 2000 or loddist < 0 then
                sampAddChatMessage(script_name.." {FFFFFF}Usar: {dc4747}"..ini.commands.loddistance.." [0-2000]", 0x73b461)
                sampAddChatMessage(script_name.." {FFFFFF}Parámetro actual: {dc4747}"..ini.settings.lod, 0x73b461)
            else
                ini.settings.lod = ("%.1f"):format(loddist)
                save()
                sliders.lod[0] = tonumber(ini.settings.lod)
                --memory.setfloat(0x858FD8, ini.settings.lod, true)
                gotofunc("LodDist")
                sampAddChatMessage(script_name.." {FFFFFF}La distancia de lod se establece en: {dc4747}"..ini.settings.lod, 0x73b461)
            end
        else
            sampAddChatMessage(script_name.." {FFFFFF}Ha desactivado la posibilidad de cambiar la distancia de lod, activar¸: {dc4747}"..ini.commands.givemedist, 0x73b461)
        end
        return false
    elseif cmd:find("^"..ini.commands.tiretracks.."$") then
        ini.settings.tiretracks = not ini.settings.tiretracks
        gotofunc("NoTireTracks")
        save()
        sampAddChatMessage(ini.settings.tiretracks and script_name..' {FFFFFF}Huellas de neumáticos {dc4747}desactivado' or script_name..' {FFFFFF}Huellas de neumáticos {73b461}activado', 0x73b461)
        return false
    elseif cmd:find("^"..ini.commands.shownicks.."$") then
        ini.settings.shownicks = not ini.settings.shownicks
        gotofunc("ShowNICKS")
        save()
        sampAddChatMessage(ini.settings.shownicks and script_name..' {FFFFFF}Nick de jugadores {dc4747}desactivado' or script_name..' {FFFFFF}Nick de jugadores {73b461}activado', 0x73b461)
        return false
    elseif cmd:find("^"..ini.commands.showhp.."$") then
        ini.settings.showhp = not ini.settings.showhp
        save()
        sampAddChatMessage(ini.settings.showhp and script_name..' {FFFFFF}Barra de vida del jugador {dc4747}desactivado' or script_name..' {FFFFFF}Barra de vida del jugador {73b461}activado', 0x73b461)
        gotofunc("ShowHP")
        return false
    elseif cmd:find("^"..ini.commands.offradio.."$") then
        ini.settings.noradio = not ini.settings.noradio
        save()
        sampAddChatMessage(ini.settings.noradio and script_name..' {FFFFFF}La radio en el transporte {73b461}activado' or script_name..' {FFFFFF}La radio en el transporte {dc4747}desactivado', 0x73b461)
        gotofunc("NoRadio")
        return false
    elseif cmd:find("^"..ini.commands.showchat.."$") then
        ini.settings.showchat = not ini.settings.showchat
        sampAddChatMessage(ini.settings.showchat and script_name..' {FFFFFF}Chat {dc4747}desactivado' or script_name..' {FFFFFF}Chat {73b461}activado', 0x73b461)
        save()
        gotofunc("ShowCHAT")
        return false
    elseif cmd:find("^"..ini.commands.showhud.."$") then
        ini.settings.showhud = not ini.settings.showhud
        sampAddChatMessage(ini.settings.showhud and script_name..' {FFFFFF}HUD {dc4747}desactivado' or script_name..' {FFFFFF}HUD {73b461}activado', 0x73b461)
        save()
        gotofunc("ShowHUD")
        return false
    elseif cmd:find("^"..ini.commands.animmoney.." .+") or cmd:find("^"..ini.commands.animmoney.."$") then
        local param = cmd:match(ini.commands.animmoney.." (.+)")
        param = tonumber(param)
        if type(param) ~= 'number' or param > 2 or param < 0 then
            sampAddChatMessage(script_name.." {FFFFFF}Usar: {DC4747}"..ini.commands.animmoney.." [0-2]", 0x73b461)
        else
            ini.settings.animmoney = param
            save()
            ivar = new.int(ini.settings.animmoney)
            if ini.settings.animmoney == 0 then
                sampAddChatMessage(script_name.." {FFFFFF}La animación de cambiar la cantidad de dinero se cambia a: {DC4747}rápido", 0x73b461)
            elseif ini.settings.animmoney == 1 then
                sampAddChatMessage(script_name.." {FFFFFF}La animación de cambiar la cantidad de dinero se cambia a: {DC4747}sin animación", 0x73b461)
            elseif ini.settings.animmoney == 2 then
                sampAddChatMessage(script_name.." {FFFFFF}La animación de cambiar la cantidad de dinero se cambia a: {DC4747}estándar", 0x73b461)
            end
        end
        return false
    elseif cmd:find("^"..ini.commands.bighpbar.."$") then
        ini.settings.bighpbar = not ini.settings.bighpbar
        sampAddChatMessage(ini.settings.bighpbar and script_name..' {FFFFFF}160hp bar {73b461}activado' or script_name..' {FFFFFF}160hp bar {dc4747}desactivado', 0x73b461)
        save()
        gotofunc("BigHPBar")
        return false
    elseif cmd:find("^"..ini.commands.fpslock.."$") then
        ini.settings.unlimitfps = not ini.settings.unlimitfps
        sampAddChatMessage(ini.settings.unlimitfps and script_name..' {FFFFFF}FPS unlock {73b461}activado' or script_name..' {FFFFFF}FPS unlock {dc4747}desactivado', 0x73b461)
        save()
        gotofunc("FPSUnlock")
        return false
    elseif cmd:find("^"..ini.commands.postfx.."$") then
        ini.settings.postfx = not ini.settings.postfx
        sampAddChatMessage(ini.settings.postfx and script_name..' {FFFFFF}Postprocesamiento {dc4747}desactivado' or script_name..' {FFFFFF}Postprocesamiento {73b461}activado', 0x73b461)
        save()
        gotofunc("NoPostfx")
        return false
    elseif cmd:find("^"..ini.commands.antiblockedplayer.."$") then
        ini.settings.antiblockedplayer = not ini.settings.antiblockedplayer
        checkboxes.antiblockedplayer[0] = ini.settings.antiblockedplayer
        save()
        sampAddChatMessage(ini.settings.antiblockedplayer and script_name..' {FFFFFF}Corrección de quedarse atascado en otros al generar {73b461}activado' or script_name..' {FFFFFF}Corrección de quedarse atascado en otros al generar {dc4747}desactivado', 0x73b461)
        return false
    elseif cmd:find("^"..ini.commands.chatopenfix.."$") then
        ini.settings.chatt = not ini.settings.chatt
        checkboxes.chatt[0] = ini.settings.chatt
        save()
        sampAddChatMessage(ini.settings.chatt and script_name..' {FFFFFF}Abrir chat en E {73b461}activado' or script_name..' {FFFFFF}Abrir chat en E {dc4747}desactivado', 0x73b461)
        return false
    elseif cmd:find("^"..ini.commands.nolimitmoneyhud.."$") then
        ini.settings.nolimitmoneyhud = not ini.settings.nolimitmoneyhud
        save()
        sampAddChatMessage(ini.settings.nolimitmoneyhud and script_name..' {FFFFFF}Eliminar el límite de dinero en el HUD {73b461}activado' or script_name..' {FFFFFF}Eliminar el límite de dinero en el HUD {dc4747}desactivado', 0x73b461)
        gotofunc("NoLimitMoneyHud")
        return false
    elseif cmd:find("^"..ini.commands.autocleaner.."$") then
        ini.cleaner.autoclean = not ini.cleaner.autoclean
        save()
        sampAddChatMessage((script_name.."{FFFFFF}Limpieza de memoria automática %s"):format(ini.cleaner.autoclean and "{73b461}activado" or "{dc4747}desactivado"), 0x73b461)
        return false
    elseif cmd:find("^"..ini.commands.cleanmemory.."$") then
        gotofunc("CleanMemory")
        return false
    elseif cmd:find("^"..ini.commands.cleaninfo.."$") then
        ini.cleaner.cleaninfo = not ini.cleaner.cleaninfo
        save()
        checkboxes.cleaninfo[0] = ini.cleaner.cleaninfo
        sampAddChatMessage(ini.cleaner.cleaninfo and script_name..' {FFFFFF}Mensaje de limpieza de memoria {73b461}activado' or script_name..' {FFFFFF}Mensaje de limpieza de memoria {dc4747}desactivado', 0x73b461)
        return false
    elseif cmd:find("^"..ini.commands.setmbforautocleaner.." .+") or cmd:find("^"..ini.commands.setmbforautocleaner.."$") then
        local setccl = cmd:match(ini.commands.setmbforautocleaner.." (.+)")
        setccl = tonumber(setccl)
        if type(setccl) ~= 'number' or setccl > 3000 or setccl < 0 then
            sampAddChatMessage(script_name.." {FFFFFF}Usar: {dc4747}"..ini.commands.setmbforautocleaner.." [0-3000 mb]", 0x73b461)
            sampAddChatMessage(script_name.." {FFFFFF}Parámetro actual: {dc4747}"..ini.cleaner.limit.." mb", 0x73b461)
        else
            ini.cleaner.limit = setccl
            save()
            sampAddChatMessage(script_name.." {FFFFFF}La limpieza automática de la memoria está configurada para: {dc4747}"..ini.cleaner.limit.." mb", 0x73b461)
        end
        return false
    elseif cmd:find("^"..ini.commands.brightness.." .+") or cmd:find("^"..ini.commands.brightness.."$") then
        local param = cmd:match(ini.commands.brightness.." (.+)")
        param = tonumber(param)
        if type(param) ~= 'number' or param > 600 or param < 0 then
            sampAddChatMessage(script_name.." {FFFFFF}Usar: {dc4747}"..ini.commands.brightness.." [0-600]", 0x73b461)
            sampAddChatMessage(script_name.." {FFFFFF}Parámetro actual: {dc4747}"..ini.settings.brightness, 0x73b461)
        else
            ini.settings.brightness = param
            save()
            sliders.brightness[0] = ini.settings.brightness
            gotofunc("SetBrightness")
            sampAddChatMessage(script_name.." {FFFFFF}El brillo se establece en: {dc4747}"..ini.settings.brightness, 0x73b461)
        end
        return false
    elseif cmd:find("^"..ini.commands.nobirds.."$") then
        ini.settings.nobirds = not ini.settings.nobirds
        save()
        sampAddChatMessage(ini.settings.nobirds and script_name..' {FFFFFF}Pájaros {dc4747}desactivado' or script_name..' {FFFFFF}Pájaros {73b461}activado', 0x73b461)
        gotofunc("NoBirds")
        return false
    elseif cmd:find("^"..ini.commands.fixtimecyc.."$") then
        ini.fixtimecyc.active = not ini.fixtimecyc.active
        sampAddChatMessage(ini.fixtimecyc.active and script_name..' {FFFFFF}Corrección del ciclo del tiempo para postprocesamiento deshabilitado {73b461}activado' or script_name..' {FFFFFF}Corrección de timecyc oscuro para postprocesamiento deshabilitado {dc4747}desactivado', 0x73b461)
        save()
        checkboxes.fixtimecyc[0] = ini.fixtimecyc.active
        gotofunc("FixTimecyc")
        return false
    elseif cmd:find("^"..ini.commands.aamb.." .+") or cmd:find("^"..ini.commands.aamb.."$") then
        local param = cmd:match(ini.commands.aamb.." (.+)")
        param = tonumber(param)
        if ini.fixtimecyc.active then
            if type(param) ~= 'number' or param < -1.000 or param > 1.000 then
                sampAddChatMessage(script_name.." {FFFFFF}Usar: {dc4747}"..ini.commands.aamb.." [de -1.000 a 1.000]", 0x73b461)
                sampAddChatMessage(script_name.." {FFFFFF}Parámetro actual: {dc4747}"..ini.fixtimecyc.allambient, 0xd73b461)
            else
                ini.fixtimecyc.allambient = param
                save()
                gotofunc("FixTimecyc")
                sampAddChatMessage(script_name.." {FFFFFF}Iluminación general configurada para: {dc4747}"..ini.fixtimecyc.allambient, 0xd73b461)
            end
        else
            sampAddChatMessage(script_name.." {FFFFFF}Ha desactivado la corrección del ciclo de tiempo, para activarlo use: {dc4747}"..ini.commands.fixtimecyc, 0x73b461)
        end
        return false
    elseif cmd:find("^"..ini.commands.oamb.." .+") or cmd:find("^"..ini.commands.oamb.."$") then
        local param = cmd:match(ini.commands.oamb.." (.+)")
        param = tonumber(param)
        if ini.fixtimecyc.active then
            if type(param) ~= 'number' or param < -1.000 or param > 1.000 then
                sampAddChatMessage(script_name.." {FFFFFF}Usar: {dc4747}"..ini.commands.oamb.." [de -1.000 a 1.000]", 0x73b461)
                sampAddChatMessage(script_name.." {FFFFFF}Parámetro actual: {dc4747}"..ini.fixtimecyc.objambient, 0xd73b461)
            else
                ini.fixtimecyc.objambient = param
                save()
                gotofunc("FixTimecyc")
                sampAddChatMessage(script_name.." {FFFFFF}La iluminación de objetos y peds se establece en: {dc4747}"..ini.fixtimecyc.objambient, 0xd73b461)
            end
        else
            sampAddChatMessage(script_name.." {FFFFFF}Ha desactivado la corrección del ciclo de tiempo, para activarlo use: {dc4747}"..ini.commands.fixtimecyc, 0x73b461)
        end
        return false
    elseif cmd:find("^"..ini.commands.wamb.." .+") or cmd:find("^"..ini.commands.wamb.."$") then
        local R = cmd:match(ini.commands.wamb.." (.+)%s.+%s.+")
        local G = cmd:match(ini.commands.wamb.." .+%s(.+)%s.+")
        local B = cmd:match(ini.commands.wamb..".+%s.+%s(.+)")
        R = tonumber(R)
        G = tonumber(G)
        B = tonumber(B)
        if ini.fixtimecyc.active then
            if type(R) ~= 'number' or type(G) ~= 'number' or type(B) ~= 'number' or R > 1.000 or R < -1.000 or G > 1.000 or G < -1.000 or B > 1.000 or B < -1.000 then
                sampAddChatMessage(script_name.." {FFFFFF}Usar: {dc4747}"..ini.commands.wamb.." [R de -1.000 a 1.000] [G de -1.000 a 1.000] [B de -1.000 a 1.000]", 0xd73b461)
                sampAddChatMessage(script_name.." {FFFFFF}Parámetros actuales: {dc4747}R: "..ini.fixtimecyc.worldambientR.." G: "..ini.fixtimecyc.worldambientG.." B: "..ini.fixtimecyc.worldambientB, 0xd73b461)
            else
                ini.fixtimecyc.worldambientR = R
                ini.fixtimecyc.worldambientG = G
                ini.fixtimecyc.worldambientB = B
                save()
                gotofunc("FixTimecyc")
                sampAddChatMessage(script_name.." {FFFFFF}Iluminación mundial configurada para: {dc4747}R: "..ini.fixtimecyc.worldambientR.." G: "..ini.fixtimecyc.worldambientG.." B: "..ini.fixtimecyc.worldambientB, 0xd73b461)
            end
        else
            sampAddChatMessage(script_name.." {FFFFFF}Ha desactivado la corrección del ciclo de tiempo, para activarlo use: {dc4747}"..ini.commands.fixtimecyc, 0x73b461)
        end --- VYR
        return false
    elseif cmd:find("^"..ini.commands.editcrosshair.." .+%s.+") or cmd:find("^"..ini.commands.editcrosshair.."$") then
        local crX1 = cmd:match(ini.commands.editcrosshair.." (.+)%s.+")
        local crY1 = cmd:match(ini.commands.editcrosshair.." .+%s(.+)")
        crX1 = tonumber(crX1)
        crY1 = tonumber(crY1)
        if type(crY1) ~= 'number' or type(crX1) ~= 'number' or crX1 > 1000 or crX1 < 0 or crY1 > 1000 or crY1 < 0 then
            sampAddChatMessage(script_name.." {FFFFFF}Usar: {dc4747}"..ini.commands.editcrosshair.." [X: 0-1000] [Y: 0-1000]", 0x73b461)
            sampAddChatMessage(script_name.." {FFFFFF}Parámetros actuales: {dc4747}X: "..ini.settings.crosshairX.." Y: "..ini.settings.crosshairY, 0x73b461)
        else
            ini.settings.crosshairX = crX1
            ini.settings.crosshairY = crY1
            buffers.vmenu_crx[0] = crX1
            buffers.vmenu_cry[0] = crY1
            save()
            gotofunc("EditCrosshair")
            sampAddChatMessage(script_name.." {FFFFFF}Tamaño de la mira: {dc4747}X: "..ini.settings.crosshairX.." Y: "..ini.settings.crosshairY, 0x73b461)
        end
        return false
    elseif cmd:find("^"..ini.commands.shadowedit.."$") then
        ini.settings.shadowedit = not ini.settings.shadowedit
        save()
        sampAddChatMessage(ini.settings.shadowedit and script_name..' {FFFFFF}Editor de sombras {73b461}activado' or script_name..' {FFFFFF}Editor de sombras {dc4747}desactivado', 0x73b461)
        gotofunc("ShadowEdit")
        return false
    elseif cmd:find("^"..ini.commands.nocloudbig.."$") then
        ini.settings.nocloudbig = not ini.settings.nocloudbig
        save()
        sampAddChatMessage(ini.settings.nocloudbig and script_name..' {FFFFFF}Nubes altas {dc4747}desactivado' or script_name..' {FFFFFF}Nubes altas {73b461}activado', 0x73b461)
        gotofunc("NoCloudBig")
        return false
    elseif cmd:find("^"..ini.commands.nocloudsmall.."$") then
        ini.settings.nocloudsmall = not ini.settings.nocloudsmall
        save()
        sampAddChatMessage(ini.settings.nocloudsmall and script_name..' {FFFFFF}Nubes bajas {dc4747}desactivado' or script_name..' {FFFFFF}Nubes bajas {73b461}activado', 0x73b461)
        gotofunc("NoCloudSmall")
        return false
    elseif cmd:find("^"..ini.commands.nocloudhorizont.."$") then
        ini.settings.nocloudhorizont = not ini.settings.nocloudhorizont
        save()
        sampAddChatMessage(ini.settings.nocloudhorizont and script_name..' {FFFFFF}Nubes en el horizonte {dc4747}desactivado' or script_name..' {FFFFFF}Nubes en el horizonte {73b461}activado', 0x73b461)
        gotofunc("NoCloudHorizont")
        return false
    elseif cmd:find("^"..ini.commands.noshadows.."$") then
        ini.settings.noshadows = not ini.settings.noshadows
        save()
        sampAddChatMessage(ini.settings.noshadows and script_name..' {FFFFFF}Eliminar sombras {dc4747}desactivado' or script_name..' {FFFFFF}Eliminar sombras {73b461}activado', 0x73b461)
        gotofunc("NoShadows")
        return false
    elseif cmd:find("^"..ini.commands.fixcrosshair.."$") then
        ini.settings.fixcrosshair = not ini.settings.fixcrosshair
        save()
        sampAddChatMessage(ini.settings.fixcrosshair and script_name..' {FFFFFF}Corrección del punto blanco en la mira {73b461}activado' or script_name..' {FFFFFF}Corrección del punto blanco en la mira {dc4747}desactivado', 0x73b461)
        gotofunc("FixCrosshair")
        return false
    elseif cmd:find("^"..ini.commands.waterfixquadro.."$") then
        ini.settings.waterfixquadro = not ini.settings.waterfixquadro -- VYR
        save()
        sampAddChatMessage(ini.settings.waterfixquadro and script_name..' {FFFFFF}Correccion de agua cuadrada {73b461}activado' or script_name..' {FFFFFF}Correccion de agua cuadrada {dc4747}desactivado', 0x73b461)
        gotofunc("FixWaterQuadro")
        return false
    elseif cmd:find("^"..ini.commands.longarmfix.."$") then
        ini.settings.longarmfix = not ini.settings.longarmfix
        save()
        sampAddChatMessage(ini.settings.longarmfix and script_name..' {FFFFFF}Corrección de brazos largo {73b461}activado' or script_name..' {FFFFFF}Corrección de brazos largo {dc4747}desactivado', 0x73b461)
        gotofunc("FixLongArm")
        return false
    elseif cmd:find("^"..ini.commands.fixblackroads.."$") then
        ini.settings.fixblackroads = not ini.settings.fixblackroads
        save()
        sampAddChatMessage(ini.settings.fixblackroads and script_name..' {FFFFFF}Corrección de carreteras negras {73b461}activado' or script_name..' {FFFFFF}Corrección de carreteras negras {dc4747}desactivado', 0x73b461)
        gotofunc("FixBlackRoads")
        return false
    elseif cmd:find("^"..ini.commands.sensfix.."$") then
        ini.settings.sensfix = not ini.settings.sensfix
        save()
        sampAddChatMessage(ini.settings.sensfix and script_name..' {FFFFFF}Corrección de la sensibilidad del mouse a lo largo del eje X y Y {73b461}activado' or script_name..' {FFFFFF}Corrección de la sensibilidad del mouse a lo largo del eje X y Y {dc4747}desactivado', 0x73b461)
        gotofunc("FixSensitivity")
        return false
    elseif cmd:find("^"..ini.commands.audiostream.."$") then
        ini.settings.audiostream = not ini.settings.audiostream
        save()
        sampAddChatMessage(ini.settings.audiostream and script_name..' {FFFFFF}Audiostream {73b461}activado' or script_name..' {FFFFFF}Audiostream {dc4747}desactivado', 0x73b461)
        gotofunc("AudioStream")
        return false
    elseif cmd:find("^"..ini.commands.intmusic.."$") then
        ini.settings.intmusic = not ini.settings.intmusic
        save()
        sampAddChatMessage(ini.settings.intmusic and script_name..' {FFFFFF}Música en interiores {73b461}activado' or script_name..' {FFFFFF}Música en interiores {dc4747}desactivado', 0x73b461)
        gotofunc("InteriorMusic")
        return false
    elseif cmd:find("^"..ini.commands.sounds.."$") then
        ini.settings.sounds = not ini.settings.sounds
        save()
        sampAddChatMessage(ini.settings.sounds and script_name..' {FFFFFF}Sonidos del juego {73b461}activado' or script_name..' {FFFFFF}Sonidos del juego {dc4747}desactivado', 0x73b461)
        gotofunc("NoSounds")
        return false
    elseif cmd:find("^"..ini.commands.noplaneline.."$") then
        ini.settings.noplaneline = not ini.settings.noplaneline
        save()
        sampAddChatMessage(ini.settings.noplaneline and script_name..' {FFFFFF}Rayas de avión en el cielo {dc4747}desactivado' or script_name..' {FFFFFF}Rayas de avión en el cielo {73b461}activado', 0x73b461)
        gotofunc("NoPlaneLine")
        return false
    elseif cmd:find("^"..ini.commands.sunfix.."$") then
        ini.settings.sunfix = not ini.settings.sunfix
        save()
        sampAddChatMessage(ini.settings.sunfix and script_name..' {FFFFFF}Corrección del sol {73b461}activado' or script_name..' {FFFFFF}Corrección del sol {dc4747}desactivado', 0x73b461)
        gotofunc("SunFix")
        return false
    elseif cmd:find("^"..ini.commands.targetblip.."$") then
        ini.settings.targetblip = not ini.settings.targetblip
        save()
        sampAddChatMessage(ini.settings.targetblip and script_name..' {FFFFFF}Triangulo encima de jugadores al apuntar {73b461}activado' or script_name..' {FFFFFF}Triangulo encima de jugadores al apuntar {dc4747}desactivado', 0x73b461)
        gotofunc("TargetBlip")
        return false
    elseif cmd:find("^"..ini.commands.vsync.."$") then
        ini.settings.vsync = not ini.settings.vsync
        save()
        sampAddChatMessage(ini.settings.vsync and script_name..' {FFFFFF}sincronización vertical (Vsync) {73b461}activado' or script_name..' {FFFFFF}sincronización vertical (Vsync) {dc4747}desactivado', 0x73b461)
        gotofunc("Vsync")
        return false
    elseif cmd:find("^"..ini.commands.radarfix.."$")then
        ini.settings.radarfix = not ini.settings.radarfix
        save()
        sampAddChatMessage(ini.settings.radarfix and script_name..' {FFFFFF}Editor de radar {73b461}activado' or script_name..' {FFFFFF}Editor de radar {dc4747}desactivado', 0x73b461)
        gotofunc("Radarfix")
        return false
    elseif cmd:find("^"..ini.commands.radar_color_fix.."$")then
        ini.settings.radar_color_fix = not ini.settings.radar_color_fix
        save()
        checkboxes.radar_color_fix[0] = ini.settings.radar_color_fix
        sampAddChatMessage(ini.settings.radar_color_fix and script_name..' {FFFFFF}Corrección del color del radar {73b461}activado' or script_name..' {FFFFFF}Corrección del color del radar {dc4747}desactivado', 0x73b461)
        gotofunc("RadarColorFix")
        return false
    elseif cmd:find("^"..ini.commands.dual_monitor_fix.."$")then
        ini.settings.dual_monitor_fix = not ini.settings.dual_monitor_fix
        save()
        checkboxes.dual_monitor_fix[0] = ini.settings.dual_monitor_fix
        sampAddChatMessage(ini.settings.dual_monitor_fix and script_name..' {FFFFFF}Corrección de salida de mouse al segundo monitor {73b461}activado' or script_name..' {FFFFFF}Corrección de salida de mouse al segundo monitor {dc4747}desactivado', 0x73b461)
        return false
    elseif cmd:find("^"..ini.commands.radarWidth.." .+") or cmd:find("^"..ini.commands.radarWidth.."$")then
        local param = cmd:match(ini.commands.radarWidth.." (.+)")
        param = tonumber(param)
        if type(param) ~= 'number' then
            sampAddChatMessage(script_name.." {FFFFFF}Usar: {dc4747}"..ini.commands.radarWidth.." [número]", 0x73b461)
            sampAddChatMessage(script_name.." {FFFFFF}Parámetro actual: {dc4747}"..ini.settings.radarWidth, 0x73b461)
        else
            ini.settings.radarWidth = param
            save()
            sliders.radarw[0] = ini.settings.radarWidth
            gotofunc("Radarfix")
            sampAddChatMessage(script_name.." {FFFFFF}Altura del radar establecida en: {dc4747}"..ini.settings.radarWidth, 0x73b461)
        end
        return false
    elseif cmd:find("^"..ini.commands.radarHeight.." .+") or cmd:find("^"..ini.commands.radarHeight.."$")then
        local param = cmd:match(ini.commands.radarHeight.." (.+)")
        param = tonumber(param)
        if type(param) ~= 'number' then
            sampAddChatMessage(script_name.." {FFFFFF}Usar: {dc4747}"..ini.commands.radarHeight.." [número]", 0x73b461)
            sampAddChatMessage(script_name.." {FFFFFF}Parámetro actual: {dc4747}"..ini.settings.radarHeight, 0x73b461)
        else
            ini.settings.radarHeight = param
            save()
            sliders.radarh[0] = ini.settings.radarHeight
            gotofunc("Radarfix")
            sampAddChatMessage(script_name.." {FFFFFF}Ancho de radar establecido en: {dc4747}"..ini.settings.radarHeight, 0x73b461)
        end
        return false
    elseif cmd:find("^"..ini.commands.radarx.." .+") or cmd:find("^"..ini.commands.radarx.."$")then
        local param = cmd:match(ini.commands.radarx.." (.+)")
        param = tonumber(param)
        if type(param) ~= 'number' then
            sampAddChatMessage(script_name.." {FFFFFF}Usar: {dc4747}"..ini.commands.radarx.." [número]", 0x73b461)
            sampAddChatMessage(script_name.." {FFFFFF}Parámetro actual: {dc4747}"..ini.settings.radarPosX, 0x73b461)
        else
            ini.settings.radarPosX = param
            save()
            sliders.radarposx[0] = ini.settings.radarPosX
            gotofunc("Radarfix")
            sampAddChatMessage(script_name.." {FFFFFF}Posición del radar X establecido en: {dc4747}"..ini.settings.radarPosX, 0x73b461)
        end
        return false
    elseif cmd:find("^"..ini.commands.radary.." .+") or cmd:find("^"..ini.commands.radary.."$")then
        local param = cmd:match(ini.commands.radary.." (.+)")
        param = tonumber(param)
        if type(param) ~= 'number' then
            sampAddChatMessage(script_name.." {FFFFFF}Usar: {dc4747}"..ini.commands.radary.." [número]", 0x73b461)
            sampAddChatMessage(script_name.." {FFFFFF}Parámetro actual: {dc4747}"..ini.settings.radarPosY, 0x73b461)
        else
            ini.settings.radarPosY = param
            save()
            sliders.radarposy[0] = ini.settings.radarPosY
            gotofunc("Radarfix")
            sampAddChatMessage(script_name.." {FFFFFF}Posición del radar Y establecida en: {dc4747}"..ini.settings.radarPosY, 0x73b461)
        end
        return false
    elseif cmd:find("^"..ini.commands.ugenrl.."$")then
        ini.ugenrl_main.enable = not ini.ugenrl_main.enable
        checkboxes.ugenrl_enable[0] = ini.ugenrl_main.enable
        if ini.ugenrl_main.enable then
            ini.settings.sounds = false
        else
            ini.settings.sounds = true
        end
        save()
        gotofunc("NoSounds")
        sampAddChatMessage(ini.ugenrl_main.enable and script_name.." {FFFFFF}Ultimate Genrl {73b461}activado" or script_name.." {FFFFFF}Ultimate Genrl {dc4747}desactivado", 0x73b461)
        return false
    elseif cmd:find("^"..ini.commands.uds.." .+") or cmd:find("^"..ini.commands.uds.."$")then
        local param = cmd:match(ini.commands.uds.." (.+)")
        param = tonumber(param)
        if type(param) ~= 'number' or param < 1 or param > tonumber(#deagleSounds) then
            sampAddChatMessage(script_name.." {FFFFFF}Usar: {dc4747}"..ini.commands.uds.." [1-"..#deagleSounds.."]", 0x73b461)
            sampAddChatMessage(script_name.." {FFFFFF}Parámetro actual: {dc4747}"..getNumberSounds(24, deagleSounds), 0x73b461)
        else
            changeSound(24, deagleSounds[param])
            save()
            sampAddChatMessage(script_name.." {FFFFFF}Sonido de deagle ajustado a: {dc4747}"..param, 0x73b461)
        end
        return false
    elseif cmd:find("^"..ini.commands.uss.." .+") or cmd:find("^"..ini.commands.uss.."$")then
        local param = cmd:match(ini.commands.uss.." (.+)")
        param = tonumber(param)
        if type(param) ~= 'number' or param < 1 or param > tonumber(#shotgunSounds) then
            sampAddChatMessage(script_name.." {FFFFFF}Usar: {dc4747}"..ini.commands.uss.." [1-"..#shotgunSounds.."]", 0x73b461)
            sampAddChatMessage(script_name.." {FFFFFF}Parámetro actual: {dc4747}"..getNumberSounds(25, shotgunSounds), 0x73b461)
        else
            changeSound(25, shotgunSounds[param])
            save()
            sampAddChatMessage(script_name.." {FFFFFF}Sonido de escopeta ajustado a: {dc4747}"..param, 0x73b461)
        end
        return false
    elseif cmd:find("^"..ini.commands.ums.." .+") or cmd:find("^"..ini.commands.ums.."$")then
        local param = cmd:match(ini.commands.ums.." (.+)")
        param = tonumber(param)
        if type(param) ~= 'number' or param < 1 or param > tonumber(#m4Sounds) then
            sampAddChatMessage(script_name.." {FFFFFF}Usar: {dc4747}"..ini.commands.ums.." [1-"..#m4Sounds.."]", 0x73b461)
            sampAddChatMessage(script_name.." {FFFFFF}Parámetro actual: {dc4747}"..getNumberSounds(31, m4Sounds), 0x73b461)
        else
            changeSound(31, m4Sounds[param])
            save()
            sampAddChatMessage(script_name.." {FFFFFF}Sonido de m4 ajustado a: {dc4747}"..param, 0x73b461)
        end
        return false
    elseif cmd:find("^"..ini.commands.urs.." .+") or cmd:find("^"..ini.commands.urs.."$")then
        local param = cmd:match(ini.commands.urs.." (.+)")
        param = tonumber(param)
        if type(param) ~= 'number' or param < 1 or param > tonumber(#rifleSounds) then
            sampAddChatMessage(script_name.." {FFFFFF}Usar: {dc4747}"..ini.commands.urs.." [1-"..#rifleSounds.."]", 0x73b461)
            sampAddChatMessage(script_name.." {FFFFFF}Parámetro actual: {dc4747}"..getNumberSounds(33, rifleSounds), 0x73b461)
        else
            changeSound(33, rifleSounds[param])
            save()
            sampAddChatMessage(script_name.." {FFFFFF}Sonido de rifle ajustado a: {dc4747}"..param, 0x73b461)
        end
        return false
    elseif cmd:find("^"..ini.commands.uuzi.." .+") or cmd:find("^"..ini.commands.uuzi.."$")then
        local param = cmd:match(ini.commands.uuzi.." (.+)")
        param = tonumber(param)
        if type(param) ~= 'number' or param < 1 or param > tonumber(#uziSounds) then
            sampAddChatMessage(script_name.." {FFFFFF}Usar: {dc4747}"..ini.commands.uuzi.." [1-"..#uziSounds.."]", 0x73b461)
            sampAddChatMessage(script_name.." {FFFFFF}Parámetro actual: {dc4747}"..getNumberSounds(28, uziSounds), 0x73b461)
        else
            changeSound(28, uziSounds[param])
            save()
            sampAddChatMessage(script_name.." {FFFFFFSonido de uzi ajustado a: {dc4747}"..param, 0x73b461)
        end
        return false
    elseif cmd:find("^"..ini.commands.ump5.." .+") or cmd:find("^"..ini.commands.ump5.."$")then
        local param = cmd:match(ini.commands.ump5.." (.+)")
        param = tonumber(param)
        if type(param) ~= 'number' or param < 1 or param > tonumber(#mp5Sounds) then
            sampAddChatMessage(script_name.." {FFFFFF}Usar: {dc4747}"..ini.commands.ump5.." [1-"..#mp5Sounds.."]", 0x73b461)
            sampAddChatMessage(script_name.." {FFFFFF}Parámetro actual: {dc4747}"..getNumberSounds(29, mp5Sounds), 0x73b461)
        else
            changeSound(29, mp5Sounds[param])
            save()
            sampAddChatMessage(script_name.." {FFFFFF}Sonido de mp5 ajustado a: {dc4747}"..param, 0x73b461)
        end
        return false
    elseif cmd:find("^"..ini.commands.ubs.." .+") or cmd:find("^"..ini.commands.ubs.."$")then
        local param = cmd:match(ini.commands.ubs.." (.+)")
        param = tonumber(param)
        if type(param) ~= 'number' or param < 1 or param > tonumber(#hitSounds) then
            sampAddChatMessage(script_name.." {FFFFFF}Usar: {dc4747}"..ini.commands.ubs.." [1-"..#hitSounds.."]", 0x73b461)
            sampAddChatMessage(script_name.." {FFFFFF}Parámetro actual: {dc4747}"..getNumberSounds("hit", hitSounds), 0x73b461)
        else
            changeSound("hit", hitSounds[param])
            save()
            sampAddChatMessage(script_name.." {FFFFFF}Sonido de hitsound ajustado a: {dc4747}"..param, 0x73b461)
        end
        return false
    elseif cmd:find("^"..ini.commands.ups.." .+") or cmd:find("^"..ini.commands.ups.."$")then
        local param = cmd:match(ini.commands.ups.." (.+)")
        param = tonumber(param)
        if type(param) ~= 'number' or param < 1 or param > tonumber(#painSounds) then
            sampAddChatMessage(script_name.." {FFFFFF}Usar: {dc4747}"..ini.commands.ups.." [1-"..#painSounds.."]", 0x73b461)
            sampAddChatMessage(script_name.." {FFFFFF}Parámetro actual: {dc4747}"..getNumberSounds("pain", painSounds), 0x73b461)
        else
            changeSound("pain", painSounds[param])
            save()
            sampAddChatMessage(script_name.." {FFFFFF}Sonido de golpe establecido en: {dc4747}"..param, 0x73b461)
        end
        return false
    elseif cmd:find("^"..ini.commands.ugd.." .+") or cmd:find("^"..ini.commands.ugd.."$")then
        local param = cmd:match(ini.commands.ugd.." (.+)")
        param = tonumber(param)
        if type(param) ~= 'number' or param < 0 or param > 100 then
            sampAddChatMessage(script_name.." {FFFFFF}Usar: {dc4747}"..ini.commands.ugd.." [0-100]", 0x73b461)
            sampAddChatMessage(script_name.." {FFFFFF}Parámetro actual: {dc4747}"..ini.ugenrl_main.enemyWeaponDist, 0x73b461)
        else
            ini.ugenrl_main.enemyWeaponDist = param
            save()
            sampAddChatMessage(script_name.." {FFFFFF}El rango de los sonidos de los tiros de los jugadores se establece en: {dc4747}"..ini.ugenrl_main.enemyWeaponDist, 0x73b461)
        end
        return false
    elseif cmd:find("^"..ini.commands.ugvw.." .+") or cmd:find("^"..ini.commands.ugvw.."$")then
        local param = cmd:match(ini.commands.ugvw.." (.+)")
        param = tonumber(param)
        if type(param) ~= 'number' or param < 0.00 or param > 1.00 then
            sampAddChatMessage(script_name.." {FFFFFF}Usar: {dc4747}"..ini.commands.ugvw.." [0.0-1.00]", 0x73b461)
            sampAddChatMessage(script_name.." {FFFFFF}Parámetro actual: {dc4747}"..ini.ugenrl_volume.weapon, 0x73b461)
        else
            ini.ugenrl_volume.weapon = param
            save()
            sampAddChatMessage(script_name.." {FFFFFF}Volumen de sonido de disparo ajustado a: {dc4747}"..ini.ugenrl_volume.weapon, 0x73b461)
        end
        return false
    elseif cmd:find("^"..ini.commands.ugvh.." .+") or cmd:find("^"..ini.commands.ugvh.."$")then
        local param = cmd:match(ini.commands.ugvh.." (.+)")
        param = tonumber(param)
        if type(param) ~= 'number' or param < 0.00 or param > 1.00 then
            sampAddChatMessage(script_name.." {FFFFFF}Usar: {dc4747}"..ini.commands.ugvh.." [0.0-1.00]", 0x73b461)
            sampAddChatMessage(script_name.." {FFFFFF}Parámetro actual: {dc4747}"..ini.ugenrl_volume.hit, 0x73b461)
        else
            ini.ugenrl_volume.hit = param
            save()
            sampAddChatMessage(script_name.." {FFFFFF}El volumen del sonido de hitsound esta ajustado a: {dc4747}"..ini.ugenrl_volume.hit, 0x73b461)
        end
        return false
    elseif cmd:find("^"..ini.commands.ugvp.." .+") or cmd:find("^"..ini.commands.ugvp.."$")then
        local param = cmd:match(ini.commands.ugvp.." (.+)")
        param = tonumber(param)
        if type(param) ~= 'number' or param < 0.00 or param > 1.00 then
            sampAddChatMessage(script_name.." {FFFFFF}Usar: {dc4747}"..ini.commands.ugvp.." [0.0-1.00]", 0x73b461)
            sampAddChatMessage(script_name.." {FFFFFF}Parámetro actual: {dc4747}"..ini.ugenrl_volume.pain, 0x73b461)
        else
            ini.ugenrl_volume.pain = param
            save()
            sampAddChatMessage(script_name.." {FFFFFF}El volumen del sonido del dolor está ajustado a: {dc4747}"..ini.ugenrl_volume.pain, 0x73b461)
        end
        return false
    elseif cmd:find("^"..ini.commands.forceaniso.."$")then
        ini.settings.forceaniso = not ini.settings.forceaniso
        save()
        sampAddChatMessage(ini.settings.forceaniso and script_name..' {FFFFFF}Filtrado anisotrópico {73b461}activado' or script_name..' {FFFFFF}Filtrado anisotrópico {dc4747}desactivado', 0x73b461)
        gotofunc("ForceAniso")
        return false
    elseif cmd:find("^"..ini.commands.moneyzerofix.."$")then
        ini.settings.moneyzerofix = not ini.settings.moneyzerofix
        save()
        sampAddChatMessage(ini.settings.moneyzerofix and script_name..' {FFFFFF}Cambiar el formato de visualización del dinero {73b461}activado' or script_name..' {FFFFFF}Cambiar el formato de visualización del dinero {dc4747}desactivado', 0x73b461)
        gotofunc("MoneyZeroFix")
        return false
    elseif cmd:find("^"..ini.commands.mapzoomfixer.."$")then
        ini.settings.mapzoomfixer = not ini.settings.mapzoomfixer
        checkboxes.mapzoomfixer[0] = ini.settings.mapzoomfixer
        save()
        sampAddChatMessage(ini.settings.mapzoomfixer and script_name..' {FFFFFF}Corrección de la sensibilidad débil para el zoom del mapa {73b461}activado' or script_name..' {FFFFFF}Corrección de la sensibilidad débil para el zoom del mapa {dc4747}desactivado', 0x73b461)
        return false
    elseif cmd:find("^"..ini.commands.shadowcp.." .+") or cmd:find("^"..ini.commands.shadowcp.."$")then
        local param = cmd:match(ini.commands.shadowcp.." (.+)")
        param = tonumber(param)
        if ini.settings.shadowedit then
            if type(param) ~= 'number' or param < 0 or param > 255 then
                sampAddChatMessage(script_name.." {FFFFFF}Usar: {dc4747}"..ini.commands.shadowcp.." [0-255]", 0x73b461)
                sampAddChatMessage(script_name.." {FFFFFF}Parámetro actual: {dc4747}"..ini.settings.shadowcp, 0x73b461)
            else
                ini.settings.shadowcp = param
                save()
                sliders.shadowcp[0] = ini.settings.shadowcp
                gotofunc("ShadowEdit")
                sampAddChatMessage(script_name.." {FFFFFF}Las sombras principales se establecen en: {dc4747}"..ini.settings.shadowcp, 0x73b461)
            end
        else
            sampAddChatMessage(script_name.." {FFFFFF}Ha desactivado la capacidad de cambiar las sombras, para activar: {dc4747}"..ini.commands.shadowedit, 0x73b461)
        end
        return false
    elseif cmd:find("^"..ini.commands.shadowlight.." .+") or cmd:find("^"..ini.commands.shadowlight.."$")then
        local param = cmd:match(ini.commands.shadowlight.." (.+)")
        param = tonumber(param)
        if ini.settings.shadowedit then
            if type(param) ~= 'number' or param < 0 or param > 255 then
                sampAddChatMessage(script_name.." {FFFFFF}Usar: {dc4747}"..ini.commands.shadowlight.." [0-255]", 0x73b461)
                sampAddChatMessage(script_name.." {FFFFFF}Parámetro actual: {dc4747}"..ini.settings.shadowlight, 0x73b461)
            else
                ini.settings.shadowlight = param
                save()
                sliders.shadowlight[0] = ini.settings.shadowlight
                gotofunc("ShadowEdit")
                sampAddChatMessage(script_name.." {FFFFFF}Sombras de pilares configuradas para: {dc4747}"..ini.settings.shadowlight, 0x73b461)
            end
        else
            sampAddChatMessage(script_name.." {FFFFFF}Ha desactivado la capacidad de cambiar las sombras, para activar: {dc4747}"..ini.commands.shadowedit, 0x73b461)
        end
        return false
    elseif cmd:find("^"..ini.commands.setfps.." .+") or cmd:find("^"..ini.commands.setfps.."$")then
        local param = cmd:match(ini.commands.setfps.." (.+)")
        param = tonumber(param)
        if type(param) ~= 'number' or param < 5 or param > 300 then
            sampAddChatMessage(script_name.." {FFFFFF}Usar: {dc4747}"..ini.commands.setfps.." [5-300]", 0x73b461)
            sampAddChatMessage(script_name.." {FFFFFF}Parámetro actual: {dc4747}"..ini.smart_fps.pedfps, 0x73b461)
        else
            ini.smart_fps.pedfps = param
            save()
            sliders.pedfps[0] = ini.smart_fps.pedfps
            sampAddChatMessage(script_name.." {FFFFFF}FPS del jugador está configurado para: {dc4747}"..ini.smart_fps.pedfps, 0x73b461)
        end
        return false
    elseif cmd:find("^"..ini.commands.vehfps.." .+") or cmd:find("^"..ini.commands.vehfps.."$")then
        local param = cmd:match(ini.commands.vehfps.." (.+)")
        param = tonumber(param)
        if type(param) ~= 'number' or param < 5 or param > 300 then
            sampAddChatMessage(script_name.." {FFFFFF}Usar: {dc4747}"..ini.commands.vehfps.." [5-300]", 0x73b461)
            sampAddChatMessage(script_name.." {FFFFFF}Parámetro actual: {dc4747}"..ini.smart_fps.vehfps, 0x73b461)
        else
            ini.smart_fps.vehfps = param
            save()
            sliders.vehfps[0] = ini.smart_fps.vehfps
            sampAddChatMessage(script_name.." {FFFFFF}FPS en vehículos está configurado para: {dc4747}"..ini.smart_fps.vehfps, 0x73b461)
        end
        return false
    elseif cmd:find("^"..ini.commands.motofps.." .+") or cmd:find("^"..ini.commands.motofps.."$")then
        local param = cmd:match(ini.commands.motofps.." (.+)")
        param = tonumber(param)
        if type(param) ~= 'number' or param < 5 or param > 300 then
            sampAddChatMessage(script_name.." {FFFFFF}Usar: {dc4747}"..ini.commands.motofps.." [5-300]", 0x73b461)
            sampAddChatMessage(script_name.." {FFFFFF}Parámetro actual: {dc4747}"..ini.smart_fps.motofps, 0x73b461)
        else
            ini.smart_fps.motofps = param
            save()
            sliders.motofps[0] = ini.smart_fps.motofps
            sampAddChatMessage(script_name.." {FFFFFF}FPS en moto está configurado para: {dc4747}"..ini.smart_fps.motofps, 0x73b461)
        end
        return false
    elseif cmd:find("^"..ini.commands.bikefps.." .+") or cmd:find("^"..ini.commands.bikefps.."$")then
        local param = cmd:match(ini.commands.bikefps.." (.+)")
        param = tonumber(param)
        if type(param) ~= 'number' or param < 5 or param > 300 then
            sampAddChatMessage(script_name.." {FFFFFF}Usar: {dc4747}"..ini.commands.bikefps.." [5-300]", 0x73b461)
            sampAddChatMessage(script_name.." {FFFFFF}Parámetro actual: {dc4747}"..ini.smart_fps.bikefps, 0x73b461)
        else
            ini.smart_fps.bikefps = param
            save()
            sliders.bikefps[0] = ini.smart_fps.bikefps
            sampAddChatMessage(script_name.." {FFFFFF}FPS en bicicletas está configurado para: {dc4747}"..ini.smart_fps.bikefps, 0x73b461)
        end
        return false
    elseif cmd:find("^"..ini.commands.boatfps.." .+") or cmd:find("^"..ini.commands.boatfps.."$")then
        local param = cmd:match(ini.commands.boatfps.." (.+)")
        param = tonumber(param)
        if type(param) ~= 'number' or param < 5 or param > 300 then
            sampAddChatMessage(script_name.." {FFFFFF}Usar: {dc4747}"..ini.commands.boatfps.." [5-300]", 0x73b461)
            sampAddChatMessage(script_name.." {FFFFFF}Parámetro actual: {dc4747}"..ini.smart_fps.boatfps, 0x73b461)
        else
            ini.smart_fps.boatfps = param
            save()
            sliders.boatfps[0] = ini.smart_fps.boatfps
            sampAddChatMessage(script_name.." {FFFFFF}FPS en botes está configurado para: {dc4747}"..ini.smart_fps.boatfps, 0x73b461)
        end
        return false
    elseif cmd:find("^"..ini.commands.planefps.." .+") or cmd:find("^"..ini.commands.planefps.."$")then
        local param = cmd:match(ini.commands.planefps.." (.+)")
        param = tonumber(param)
        if type(param) ~= 'number' or param < 5 or param > 300 then
            sampAddChatMessage(script_name.." {FFFFFF}Usar: {dc4747}"..ini.commands.planefps.." [5-300]", 0x73b461)
            sampAddChatMessage(script_name.." {FFFFFF}Parámetro actual: {dc4747}"..ini.smart_fps.planefps, 0x73b461)
        else
            ini.smart_fps.planefps = param
            save()
            sliders.planefps[0] = ini.smart_fps.planefps
            sampAddChatMessage(script_name.." {FFFFFF}FPS en aviones está configurado para: {dc4747}"..ini.smart_fps.planefps, 0x73b461)
        end
        return false
    elseif cmd:find("^"..ini.commands.helifps.." .+") or cmd:find("^"..ini.commands.helifps.."$")then
        local param = cmd:match(ini.commands.helifps.." (.+)")
        param = tonumber(param)
        if type(param) ~= 'number' or param < 5 or param > 300 then
            sampAddChatMessage(script_name.." {FFFFFF}Usar: {dc4747}"..ini.commands.helifps.." [5-300]", 0x73b461)
            sampAddChatMessage(script_name.." {FFFFFF}Parámetro actual: {dc4747}"..ini.smart_fps.helifps, 0x73b461)
        else
            ini.smart_fps.helifps = param
            save()
            sliders.helifps[0] = ini.smart_fps.helifps
            sampAddChatMessage(script_name.." {FFFFFF}FPS en aviones está configurado para: {dc4747}"..ini.smart_fps.helifps, 0x73b461)
        end
        return false
    elseif cmd:find("^"..ini.commands.swimfps.." .+") or cmd:find("^"..ini.commands.swimfps.."$")then
        local param = cmd:match(ini.commands.swimfps.." (.+)")
        param = tonumber(param)
        if type(param) ~= 'number' or param < 5 or param > 300 then
            sampAddChatMessage(script_name.." {FFFFFF}Usar: {dc4747}"..ini.commands.swimfps.." [5-300]", 0x73b461)
            sampAddChatMessage(script_name.." {FFFFFF}Parámetro actual: {dc4747}"..ini.smart_fps.swimfps, 0x73b461)
        else
            ini.smart_fps.swimfps = param
            save()
            sliders.swimfps[0] = ini.smart_fps.swimfps
            sampAddChatMessage(script_name.." {FFFFFF}FPS mientras nada está configurado para: {dc4747}"..ini.smart_fps.swimfps, 0x73b461)
        end
        return false
    elseif cmd:find("^"..ini.commands.snipergunfps.." .+") or cmd:find("^"..ini.commands.snipergunfps.."$")then
        local param = cmd:match(ini.commands.snipergunfps.." (.+)")
        param = tonumber(param)
        if type(param) ~= 'number' or param < 5 or param > 300 then
            sampAddChatMessage(script_name.." {FFFFFF}Usar: {dc4747}"..ini.commands.snipergunfps.." [5-300]", 0x73b461)
            sampAddChatMessage(script_name.." {FFFFFF}Parámetro actual: {dc4747}"..ini.smart_fps.snipergunfps, 0x73b461)
        else
            ini.smart_fps.snipergunfps = param
            save()
            sliders.snipergunfps[0] = ini.smart_fps.snipergunfps
            sampAddChatMessage(script_name.." {FFFFFF}FPS mientras usa Sniper está configurado para: {dc4747}"..ini.smart_fps.snipergunfps, 0x73b461)
        end
        return false
    elseif cmd:find("^"..ini.commands.spraygunfps.." .+") or cmd:find("^"..ini.commands.spraygunfps.."$") then
        local param = cmd:match(ini.commands.spraygunfps.." (.+)")
        param = tonumber(param)
        if type(param) ~= 'number' or param < 5 or param > 300 then
            sampAddChatMessage(script_name.." {FFFFFF}Usar: {dc4747}"..ini.commands.spraygunfps.." [5-300]", 0x73b461)
            sampAddChatMessage(script_name.." {FFFFFF}Parámetro actual: {dc4747}"..ini.smart_fps.spraygunfps, 0x73b461)
        else
            ini.smart_fps.spraygunfps = param
            save()
            sliders.spraygunfps[0] = ini.smart_fps.spraygunfps
            sampAddChatMessage(script_name.." {FFFFFF}FPS mientras usa Spray está configurado para: {dc4747}"..ini.smart_fps.spraygunfps, 0x73b461)
        end
        return false
    end
end

chatBubbles = chatBubbles or {};

function onReceiveRpc(id, bs)
	if ini.settings.blocktime and (id == 29 or id == 94 or id == 30) then 
        return false 
   end
    if id == 152 and ini.settings.blockweather then
        return false
    end
    if id == 59 and ini.custom_nametags.status then
        local playerId = raknetBitStreamReadInt16(bs)
        local color = raknetBitStreamReadInt32(bs)
        local dist = raknetBitStreamReadFloat(bs)
        local time = raknetBitStreamReadInt32(bs)
        local len_text = raknetBitStreamReadInt8(bs)
        local text = raknetBitStreamReadString(bs, len_text)


            -- Eliminar la burbuja de chat anterior
        for k, v in pairs(chatBubbles) do
            if v["playerid"] == playerId then
                table.remove(chatBubbles, k)
                break
            end
        end

        -- Crear una nueva burbuja de chat
        local tbl = {
            ["playerid"] = playerId,
            ["color"] = color,
            ["dist"] = dist,
            ["time"] = os.time() + time / 1000,
            ["text"] = text
        }
        table.insert(chatBubbles, tbl);
        return false
    end
end

function getMDO(id_obj) 
    return callFunction(0x403DA0, 1, 1, id_obj) + 24 -- obtener mem obj distancia
end

function hptext()
    return ini.hphud.hptext and "_".."hp" or ""
end

function gotofunc(fnc)
    
    ------------------------------------fixes and other-----------------------------
    if fnc == "all" then
        LoadPatch()
        callFunction(0x7469A0, 0, 0) --mousefix in pause

        --------[fix spawn bottle or smoke]----------
        memory.fill(0x4217F4, 0x90, 21, true)
        memory.fill(0x4218D8, 0x90, 17, true)
        memory.fill(0x5F80C0, 0x90, 10, true)
        memory.fill(0x5FBA47, 0x90, 10, true)
        ---------------------------------------------




        if get_samp_version() == "r1" then
            memory.write(sampGetBase() + 0x64ACA, 0xFB, 1, true) --Min FontSize -5
            memory.write(sampGetBase() + 0x64ACF, 0x07, 1, true) --Max FontSize 7
            memory.write(sampGetBase() + 0xD7B00, 0x7420352D, 4, true) --FontSize StringInfo
            memory.write(sampGetBase() + 0xD7B04, 0x37206F, 4, true) --FontSize StringInfo
            memory.write(sampGetBase() + 0x64A51, 0x32, 1, true) --PageSize MAX
            memory.write(sampGetBase() + 0xD7AD5, 0x35, 1, true) --PageSize StringInfo
        elseif get_samp_version() == "r3" then
            memory.write(sampGetBase() + 0x67F2A, 0xFB, 1, true) --Min FontSize -5 (valor mínimo para comando/fontsize)
            memory.write(sampGetBase() + 0x67F2F, 0x07, 1, true) --Max FontSize 7 (valor máximo para comando /fontsize)
            memory.write(sampGetBase() + 0xE9DE0, 0x7420352D, 4, true) --FontSize StringInfo (muestra información sobre el valor mínimo cuando ingresa /fontsize)
            memory.write(sampGetBase() + 0xE9DE4, 0x37206F, 4, true) --FontSize StringInfo (muestra información sobre el valor máximo cuando ingresa /fontsize)
            memory.write(sampGetBase() + 0x67EB1, 0x32, 1, true) --PageSize MAX (número máximo para /pagesize)
            memory.write(sampGetBase() + 0xE9DB5, 0x35, 1, true) --PageSize StringInfo (muestra información sobre el valor máximo cuando ingresa /pagesize)
        end
        ----------------------------------------------------------------------------
    end
    -----------------------------------------------------------------------
    if fnc == "OpenMenu" then
        gfmenu.switch()
	end
    if fnc == "OpenTws" then
        twsmenu.switch()
	end

    if fnc == "GTATime" then
        callFunction(0x52CF10, 0, 0)
        setTimeOfDay(ini.settings.hours, ini.settings.min)
        if ini.settings.gtatime then
            memory.hex2bin("56", 0x52CF10, 1)
        else
            memory.hex2bin("C3", 0x52CF10, 1)
        end
        setTimeOfDay(ini.settings.hours, ini.settings.min)
    end

    
    if fnc == "BlockWeather" or fnc == "all" then
        if get_samp_version() == "r1" then
            if ini.settings.blockweather then
                writeMemory(sampGetBase() + 0x9C130, 4, 0x0004C2, true)
            else
                writeMemory(sampGetBase() + 0x9C130, 4, 0x5D418B, true)
            end
        elseif get_samp_version() == "r3" then
            if ini.settings.blockweather then
                writeMemory(sampGetBase() + 0xA0430, 4, 0x0004C2, true)
            else
                writeMemory(sampGetBase() + 0xA0430, 4, 0x5D418B, true)
            end
        end
    end
    
    if fnc == "SetTime" or fnc == "all" then
        Im.Hours = ini.settings.hours
        Im.Mins = ini.settings.min

        setTimeOfDay(ini.settings.hours, ini.settings.min)
	end
    if fnc == "SetWeather" or fnc == "all" then
        Im.CurrWeather[0] = ini.settings.weather
        forceWeatherNow(ini.settings.weather)
	end
    
    if fnc == "BlockTime" or fnc == "all" then
        if get_samp_version() == "r1" then
            if ini.settings.blocktime then
                writeMemory(sampGetBase() + 0x9C0A0, 4, 0x000008C2, true)
            else
                writeMemory(sampGetBase() + 0x9C0A0, 4, 0x0824448B, true)
            end
        elseif get_samp_version() == "r3" then
            if ini.settings.blocktime then
                writeMemory(sampGetBase() + 0xA03A0, 4, 0x000008C2, true)
            else
                writeMemory(sampGetBase() + 0xA03A0, 4, 0x0824448B, true)
            end
        end
    end



    
    if fnc == "FixTimecyc" or fnc == "all" then
        if ini.fixtimecyc.active then
            memory.write(6359759, 144, 1, false)-- en
            memory.write(6359760, 144, 1, false)-- en
            memory.write(6359761, 144, 1, false)-- en
            memory.write(6359762, 144, 1, false)-- en
            memory.write(6359763, 144, 1, false)-- en
            memory.write(6359764, 144, 1, false)-- en
            memory.write(6359778, 144, 1, false)-- en
            memory.write(6359779, 144, 1, false)-- en
            memory.write(6359780, 144, 1, false)-- en
            memory.write(6359781, 144, 1, false)-- en
            memory.write(6359782, 144, 1, false)-- en
            memory.write(6359783, 144, 1, false)-- en
            memory.write(6359784, 144, 1, false)-- en
            memory.write(6359785, 144, 1, false)-- en
            memory.write(6359786, 144, 1, false)-- en
            memory.write(6359787, 144, 1, false)-- en
            memory.write(5637016, 12044024, 4, false)-- en
            memory.write(5637032, 12044024, 4, false)-- en
            memory.write(5637048, 12044024, 4, false)-- en
            memory.write(5636920, 12044048, 4, false)-- en
            memory.write(5636936, 12044072, 4, false)-- en
            memory.write(5636952, 12044096, 4, false)-- en

            memory.setfloat(9228384, ini.fixtimecyc.allambient, false)
            memory.setfloat(12044024, ini.fixtimecyc.objambient, false)
            memory.setfloat(12044048, ini.fixtimecyc.worldambientR, false)
            memory.setfloat(12044072, ini.fixtimecyc.worldambientG, false)
            memory.setfloat(12044096, ini.fixtimecyc.worldambientB, false)
        else
            memory.write(6359759, 217, 1, false)-- vykl
            memory.write(6359760, 21, 1, false)-- vykl
            memory.write(6359761, 96, 1, false)-- vykl
            memory.write(6359762, 208, 1, false)-- vykl
            memory.write(6359763, 140, 1, false)-- vykl
            memory.write(6359764, 0, 1, false)-- vykl
            memory.write(6359778, 199, 1, false)-- vykl
            memory.write(6359779, 5, 1, false)-- vykl
            memory.write(6359780, 96, 1, false)-- vykl
            memory.write(6359781, 208, 1, false)-- vykl
            memory.write(6359782, 140, 1, false)-- vykl
            memory.write(6359783, 0, 1, false)-- vykl
            memory.write(6359784, 0, 1, false)-- vykl
            memory.write(6359785, 0, 1, false)-- vykl
            memory.write(6359786, 128, 1, false)-- vykl
            memory.write(6359787, 63, 1, false)-- vykl
            memory.write(5637016, 12043448, 4, false)-- vykl
            memory.write(5637032, 12043452, 4, false)-- vykl
            memory.write(5637048, 12043456, 4, false)-- vykl
            memory.write(5636920, 12043424, 4, false)-- vykl
            memory.write(5636936, 12043428, 4, false)-- vykl
            memory.write(5636952, 12043432, 4, false)-- vykl
        end
    end
    if fnc == "GivemeDist" or fnc == "all" then
        if not doesFileExist(getGameDirectory()..'\\_CoreGame.asi') then
            if ini.settings.givemedist then
                memory.write(0x53EA95, 0xB7C7F0, 4, true)-- vykl
                memory.write(0x7FE621, 0xC99F68, 4, true)-- vykl
            else
                memory.write(0x53EA95, 0xB7C4F0, 4, true)-- vykl
                memory.write(0x7FE621, 0xC992F0, 4, true)-- vykl
            end
        end
	end
    if fnc == "LodDist" or fnc == "all" then
        memory.setfloat(0xCFFA11, ini.settings.lod, true)
        local aWrites = {
            [1] = 0x555172+2, [2] = 0x555198+2, [3] = 0x5551BB+2, [4] = 0x55522E+2, [5] = 0x555238+2,
            [6] = 0x555242+2, [7] = 0x5552F4+2, [8] = 0x5552FE+2, [9] = 0x555308+2, [10] = 0x555362+2,
            [11] = 0x55537A+2, [12] = 0x555388+2, [13] = 0x555A95+2, [14] = 0x555AB1+2, [15] = 0x555AFB+2,
            [16] = 0x555B05+2, [17] = 0x555B1C+2, [18] = 0x555B2A+2, [19] = 0x555B38+2, [20] = 0x555B82+2,
            [21] = 0x555B8C+2, [22] = 0x555B9A+2, [23] = 0x5545E6+2, [24] = 0x554600+2, [25] = 0x55462A+2,
            [26] = 0x5B527A+2,
        }
        for i = 0, #aWrites do
            writeMemory(aWrites[i], 4, 0xCFFA11, true)
        end
    end
    if fnc == "NoBirds" or fnc == "all" then
        if ini.settings.nobirds then
            memory.fill(0x712833, 0x90, 2, true)
        else
            memory.hex2bin('3BC5', 0x712833, 2) --nobirds
        end
	end
    if fnc == "ShadowEdit" or fnc == "all" then
        if ini.settings.shadowedit then
            memory.write(5635169, 0, 1, true)
            memory.write(5635259, 0, 1, true)
            memory.setint32(12043496, ini.settings.shadowcp, true)
            memory.setint32(12043500, ini.settings.shadowlight, true)
        else
            memory.write(5635169, 72, 1, true)
            memory.write(5635259, 76, 1, true)
        end
	end
    if fnc == "NoCloudBig" or fnc == "all" then
        if ini.settings.nocloudbig then
            memory.write(5497268, -1869574000, 4, true)--nubes altas y espesas
            memory.write(5497272, 144, 1, true)--nubes altas y espesas
        else
            memory.write(5497268, 495044584, 4, true)--nubes muy densas en
            memory.write(5497272, 0, 1, true)--nubes muy densas en
        end
	end
    if fnc == "NoCloudSmall" or fnc == "all" then
        if ini.settings.nocloudsmall then
            memory.fill(5497121, 144, 5, true)--nubes bajas apagadas
        else
            memory.write(5497121, 494111464, 4, true)--nubes bajas en
            memory.write(5497125, 0, 1, true)--nubes bajas en
        end
	end
    if fnc == "NoCloudHorizont" or fnc == "all" then
        if ini.settings.nocloudhorizont then
            writeMemory(0x70EAB0, 1, 0xC3, true)-- disable horizont clouds original byte 0x83
        else
            writeMemory(0x70EAB0, 1, 0x83, true)-- disable horizont clouds original byte 0x83
        end
	end
    if fnc == "NoShadows" or fnc == "all" then
        if ini.settings.noshadows then
            memory.write(5497177, 195, 1, true)
            memory.fill(5489067, 144, 5, true)
            memory.write(6186889, 33807, 2, true)
            memory.fill(7388587, 144, 6, true)
            memory.fill(7391066, 144, 9, true)
        else
            memory.write(5497177, 233, 1, true)
            memory.write(5489067, 492560616, 4, true)
            memory.write(5489071, 0, 1, true)
            memory.write(6186889, 59792, 2, true)
            memory.write(7388587, 111379727, 4, true)
            memory.write(7388591, 0, 2, true)
            memory.write(7391066, 32081167, 4, true)
            memory.write(7391070, -1869611008, 4, true)

            memory.hex2bin('E838A21C00', 0x53E0C3, 5)
            memory.hex2bin('E893C81C00', 0x53E0C8, 5)
            memory.hex2bin('E87D9E1C00', 0x53E0BE, 5)
        end
        if ini.settings.pedshadows then
            writeMemory(0x707B40, 1, 0xC3, true)--desactiva la sombra debajo de la piel
        else
            writeMemory(0x707B40, 1, 0x83, true)--enciende la sombra debajo de la piel
        end
        if ini.settings.vehshadows then
            --apaga la sombra debajo del transporte
            memory.fill(0x6ABCF5, 0x90, 5, true)
            memory.fill(0x6BD667, 0x90, 5, true)
            memory.fill(0x6C0B21, 0x90, 5, true)
            memory.fill(0x6C58A0, 0x90, 5, true)
            memory.fill(0x6CA73A, 0x90, 5, true)
        else
            memory.hex2bin('E8A6000600', 0x6ABCF5, 5)
            memory.hex2bin('E834E70400', 0x6BD667, 5)
            memory.hex2bin('E87AB20400', 0x6C0B21, 5)
            memory.hex2bin('E8FB640400', 0x6C58A0, 5)
            memory.hex2bin('E861160400', 0x6CA73A, 5)
        end
        if ini.settings.poleshadows then
            writeMemory(0x70C750, 1, 0xC3, true)--desactiva las sombras debajo de las columnas
        else
            writeMemory(0x70C750, 1, 0x83, true)--incluye sombras debajo de las mesas
        end
        if ini.settings.maxshadows then
            writeMemory(0x7113B0, 1, 0xC3, true)--sombras de palmeras, pilares, etc. en escenarios altos
        else
            writeMemory(0x7113B0, 1, 0x83, true)--sombras de palmeras, pilares, etc. en escenarios altos
        end
        

	end
    if fnc == "NoPostfx" or fnc == "all" then
        if ini.settings.postfx then
            memory.write(7358318, 2866, 4, true)--postfx off
            memory.write(7358314, -380152237, 4, true)--postfx off
            writeMemory(0x53E227, 1, 0xC3, true)
        else
            memory.write(7358318, 1448280247, 4, true)--postfx on
            memory.write(7358314, -988281383, 4, true)--postfx on
            writeMemory(0x53E227, 1, 0xE9, true)
        end
	end
    if fnc == "FPSUnlock" or fnc == "all" then
        if get_samp_version() == "r1" then
            if ini.settings.unlimitfps then
                memory.write(sampGetBase() + 0x9D9D1, 0x8B, 1, true)
            else
                memory.write(sampGetBase() + 0x9D9D1, 0x9B, 1, true)
            end
        elseif get_samp_version() == "r3" then
            if ini.settings.unlimitfps then
                memory.write(sampGetBase() + 0xA1F60, 0x5051FF15, 4, true)
            else
                memory.write(sampGetBase() + 0xA1F60, 0xFFF57BE8, 4, true) 
            end
        end
	end
    if fnc == "EffectsManager" or fnc == "all" then
        if ini.settings.nomorehaze then
            writeMemory(0x72C1B7, 1, 0xEB, true)
        else
            writeMemory(0x72C1B7, 1, 0x7C, true)
        end
        if ini.effects_manager.nosparks then
            writeMemory(0x49F0C4+1, 4, 0, true) -- chispas
        else
            writeMemory(0x49F0C4+1, 4, 0x3F800000, true) -- chispas
        end
        if ini.effects_manager.nowaterfog then
            writeMemory(0x6E7760, 1, 0xC3, true)
        else
            writeMemory(0x6E7760, 1, 0xA0, true)
        end
        if ini.effects_manager.breakobject then
            writeMemory(0x59E033+1, 4, 0, true)--polvo cuando los objetos se rompen
        else
            writeMemory(0x59E033+1, 4, 1041865114, true)
        end
        if ini.effects_manager.nogunfire then
            writeMemory(0x5DF365, 2, 0x9090, true) -- elimina el fuego del arma al disparar
        else
            writeMemory(0x5DF365, 2, 0x2274, true) -- elimina el fuego del arma al disparar
        end
        if ini.effects_manager.nogunsmoke then
            writeMemory(0x4A0F7F, 4, 0x90, true) -- elimina el humo de los tiros
        else
            writeMemory(0x4A0F7F, 4, 0x944CE8, true) -- elimina el humo de los tiros
        end
        if ini.effects_manager.nofxsystem then
            memory.fill(0x4A125D, 0x90, 8, true) -- 8B 4E 08 E8 47 91 00 00  FxSystem_c::Play(void)
        else
            memory.hex2bin('8B4E08E88B900000', 0x4A125D, 8) --FxSystem_c::Play(void)
        end
        if ini.effects_manager.noblood then
            memory.fill(0x49EB23, 0x90, 2, true)-- blood particle
        else
            memory.hex2bin('EB05', 0x49EB23, 2)-- blood particle
        end
        if ini.effects_manager.swim then
            memory.write(0x68AA70, 0x0004C2, 4, true) -- process swim effects ped
            memory.write(0x6C399F+1, 0, 4, true)--addsplashparticles
            memory.write(0x6C3606+1, 0, 4, true)-- gotas al caminar
            memory.write(0x4A1144, 0x0004C2, 4, true)-- salpicaduras de agua al dispararle
            memory.write(0x4A10D4, 0x0004C2, 4, true)-- water_splash
            memory.write(0x4A11B4, 0x0004C2, 4, true)

            writeMemory(0x6DD130, 4, 0x0004C2, true)-- boat splash salpicaduras de agua del transporte acuático
            writeMemory(0x6ED9A0, 4, 0xC3, true)--taladro de transporte de agua
        else
            memory.write(0x68AA70, -1587216534, 4, true)
            memory.write(0x6C399F+1, 1053609165, 4, true)
            memory.write(0x6C3606+1, 1045220557, 4, true)
            memory.write(0x4A1144, 9603048, 4, true)-- salpicaduras de agua al dispararle
            memory.write(0x4A10D4, 9631720, 4, true)-- water_splash
            memory.write(0x4A11B4, 9574376, 4, true)

            writeMemory(0x6DD130, 4, 0x80EC81, true)-- boat splash salpicaduras de agua del transporte acuático
            writeMemory(0x6ED9A0, 4, 0x83EC8B55, true)--taladro de transporte de agua
        end
        if ini.effects_manager.noexhaust then
            writeMemory(0x6DE240, 1, 0xC3, true) -- humo de las tuberías de transporte
        else
            writeMemory(0x6DE240, 1, 0x64, true) -- humo de las tuberías de transporte
        end
        if ini.effects_manager.wheelsand then
            writeMemory(0x4A06F5+1, 4, 0, true) -- arena de debajo de la rueda
            memory.write(0x4A0630, 0x9090, 2, true)-- arena
        else
            writeMemory(0x4A0AA0+1, 4, 0x3F800000, true) -- polvo debajo de las ruedas
            memory.write(0x4A0630, 0x05EB, 2, true)-- arena
        end
        if ini.effects_manager.wheeldust then
            writeMemory(0x6DEF50+1, 4, 0, true) -- polvo debajo de las ruedas
            memory.write(0x4A09E0, 0x9090, 2, true)-- polvo
        else
            writeMemory(0x6DEF50+1, 4, 0x9A99993E, true) -- polvo debajo de las ruedas
            memory.write(0x4A09E0, 0x05EB, 2, true)-- polvo
        end
        if ini.effects_manager.wheelmud then
            writeMemory(0x4A0003+1, 4, 0, true) -- suciedad debajo de las ruedas
            writeMemory(0x4A04A3+1, 4, 0, true) -- suciedad debajo de las ruedas x2
            memory.write(0x4A040E, 0x9090, 2, true) -- sucio
        else
            writeMemory(0x4A0003+1, 4, 0x3F800000, true) -- sucio de debajo de las ruedas
            writeMemory(0x4A04A3+1, 4, 0x3F800000, true) -- sucio de debajo de las ruedas x2
            memory.write(0x4A040E, 0x05EB, 2, true) -- sucio
        end
        if ini.effects_manager.wheelgravel then
            writeMemory(0x4A0253+1, 4, 0, true) -- grava de debajo de la rueda
            memory.write(0x4A01BE, 0x9090, 2, true) -- grava
        else
            writeMemory(0x4A0253+1, 4, 0x3F800000, true) -- grava de debajo de la rueda
            memory.write(0x4A01BE, 0x05EB, 2, true) -- grava
        end
        if ini.effects_manager.wheelgrass then
            memory.write(0x49FF6E, 0x9090, 2, true) -- césped
        else
            memory.write(0x49FF6E, 0x05EB, 2, true) -- césped
        end
        if ini.effects_manager.wheelspray then
            memory.write(0x49FB50, 0x9090, 2, true) -- humo
            writeMemory(0x6DF1C3+1, 4, 0, true) -- humo debajo de las ruedas
            writeMemory(0x6DF1BE+1, 4, 0, true) -- humo debajo de las ruedas
            writeMemory(0x6DED24+1, 4, 0, true) -- humo a la deriva, W+S
            writeMemory(0x6DED1A+1, 4, 0, true)
        else
            memory.write(0x49FB50, 0x05EB, 2, true) -- humo
            writeMemory(0x6DF1C3+1, 4, 0x3F800000, true) -- humo debajo de las ruedas
            writeMemory(0x6DF1BE+1, 4, 0x3F000000, true) -- äûì èç ïîä êîëåñ
            writeMemory(0x6DED24+1, 4, 0x3F333333, true) -- humo a la deriva, W+S
            writeMemory(0x6DED1A+1, 4, 0x3E99999A, true)
        end
        if ini.effects_manager.vehsparks then
            memory.setfloat(0xCB0870, -99.9, true) -- chispas al rayar el transporte
            memory.write(0x5458DA+2, 0xCB0870, 4, true)
        else
            memory.setfloat(0xCB0870, 0.0000118509, true) -- chispas al rayar el transporte
            memory.write(0x5458DA+2, 0xCB0870, 4, true)
        end
        if ini.effects_manager.vehdust then
            writeMemory(0x6C9FAF+1, 4, 0, true)-- polvo de despegue del transporte aéreo plane
            writeMemory(0x6C55F4+1, 4, 0, true)--polvo de despegue del transporte aéreo heli
        else
            writeMemory(0x6C9FAF+1, 4, 0x40000000, true)-- polvo de despegue del transporte aéreo plane
            writeMemory(0x6C55F4+1, 4, 0x3F800000, true)--ïpolvo de despegue del transporte aéreo heli
        end
        if ini.effects_manager.vehdmgdust then
            writeMemory(0x6A6E93+1, 4, 0, true)--polvo en caso de colisión entre un vehículo y objetos
        else
            writeMemory(0x6A6E93+1, 4, 0x3DCCCCCD, true)--polvo en caso de colisión entre un vehículo y objetos
        end
        if ini.effects_manager.footdust then
            writeMemory(0x5E3811+1, 4, 0, true)--foot dust
            writeMemory(0x5458E0+1, 4, 0, true)
        else
            writeMemory(0x5E3811+1, 4, 0x3E19999A, true)--foot dust
            writeMemory(0x5458E0+1, 4, 0x3DCCCCCD, true)
        end
        if ini.effects_manager.nodust then
            writeMemory(0x49F57D+1, 4, 0, true) -- polvo cuando se dispara en la arena
            writeMemory(0x49F49D+1, 4, 0, true) -- polvo en caso de colisión de una bala con una superficie, hormigón, carretera, etc.
        else
            writeMemory(0x49F57D+1, 4, 0x3ECCCCCD, true) -- polvo cuando se dispara en la arena
            writeMemory(0x49F49D+1, 4, 0x3D99999A, true) -- polvo en caso de colisión de una bala con una superficie, hormigón, carretera, etc.
        end
        if ini.effects_manager.gunshell then
            writeMemory(0x73A40A, 2, 0x9090, true)--luz
        else
            writeMemory(0x73A40A, 2, 0x0375, true)--luz
        end
        if ini.effects_manager.footprints then
            writeMemory(0x005E559C+1, 4, -1, true)-- huellas en la arena(footprints in the sand)
        else
            writeMemory(0x005E559C+1, 4, 0x40800000, true)-- huellas en la arena(footprints in the sand)
        end
        if ini.effects_manager.vehdmgsmoke then
            writeMemory(0x6D2A80, 4, 0xC3, true)--smoke dmg vehicles
        else
            writeMemory(0x6D2A80, 4, 0x5618EC83, true)--smoke dmg vehicles
        end
        if ini.effects_manager.vehtaxilight then
            memory.write(12697552, 0, 1, true)--apaga el resplandor de las fichas de taxi
        else
            memory.write(12697552, 1, 1, true)--enciende el resplandor de las damas de taxi
        end
        checkboxes.vehtaxilight[0] = ini.effects_manager.vehtaxilight
    end
    if fnc == "ShowHUD" or fnc == "all" then
        if ini.settings.showhud then
            displayHud(false)
            memory.setint8(0xBA676C, 2)
        else
            displayHud(true)
            memory.setint8(0xBA676C, 0)
        end
	end
    if fnc == "FixLoadMap" or fnc == "all" then
        --[[
        00584C6D  3B D0                                   cmp     edx, eax
        00584C6F  7C 64                                   jl      short loc_584CD5
        00584C71  41                                      inc     ecx
        00584C72  3B D1                                   cmp     edx, ecx
        00584C74  7F 5F                                   jg      short loc_584CD5
        00584C76  8B 44 24 1C                             mov     eax, [esp+14h+arg_4]
        00584C7A  8D 48 FF                                lea     ecx, [eax-1]
        00584C7D  3B D9                                   cmp     ebx, ecx
        00584C7F  7C 54                                   jl      short loc_584CD5
        00584C81  40                                      inc     eax
        00584C82  3B D8                                   cmp     ebx, eax
        00584C84  7F 4F
        ]]
        if ini.settings.fixloadmap then
            memory.fill(0x584C6D, 0x90, 0x19, true)-- fixloadmap
        else
            memory.hex2bin('3BD07C64413BD17F5F8B44241C8D48FF3BD97C54403BD87F4F', 0x584C6D, 0x19)
        end
    end
    if fnc == "ShowCHAT" or fnc == "all" then
        if get_samp_version() == "r1" then
            if ini.settings.showchat then
                memory.write(sampGetBase() + 0x7140F, 1, 1, true)
                sampSetChatDisplayMode(0)
            else
                memory.write(sampGetBase() + 0x7140F, 0, 1, true)
                sampSetChatDisplayMode(3)
            end
        elseif get_samp_version() == "r3" then
            if ini.settings.showchat then
                memory.write(sampGetBase() + 0x752FF, 1, 1, true)
                sampSetChatDisplayMode(0)
            else
                memory.write(sampGetBase() + 0x752FF, 0, 1, true)
                sampSetChatDisplayMode(3)
            end
        end
	end
    if fnc == "ShowHP" or fnc == "all" then
        if get_samp_version() == "r1" then
            if ini.settings.showhp then
                memory.setint16(sampGetBase() + 0x6FC30, 0xC390, true)
            else
                memory.setint16(sampGetBase() + 0x6FC30, 0x8B55, true)
            end
        elseif get_samp_version() == "r3" then 
            if ini.settings.showhp then
                memory.setint16(sampGetBase() + 0x73B20, 0xC390, true)
            else
                memory.setint16(sampGetBase() + 0x73B20, 0x8B55, true)
            end
        end
	end
    if fnc == "ShowNICKS" or fnc == "all" then
        if get_samp_version() == "r1" then
            if ini.settings.shownicks then
                memory.setint16(sampGetBase() + 0x70D40, 0xC390, true)
            else
                memory.setint16(sampGetBase() + 0x70D40, 0x8B55, true)
            end
        elseif get_samp_version() == "r3" then
            if ini.settings.shownicks then
                memory.setint16(sampGetBase() + 0x74C30, 0xC390, true)
            else
                memory.setint16(sampGetBase() + 0x74C30, 0x8B55, true)
            end
        end
	end
    if fnc == "FixCrosshair" or fnc == "all" then
        if ini.settings.fixcrosshair then
            memory.write(0x058E280, 0xEB, 1, true)
        else
            memory.write(0x058E280, 0x7A, 1, true)
        end
        checkboxes.fixcrosshair[0] = ini.settings.fixcrosshair
	end
    if fnc == "FixWaterQuadro" or fnc == "all" then
        if ini.settings.waterfixquadro then
            memory.setfloat(13101856, 0.0, true)
            memory.write(7249056, 13101856, 4, true)
            memory.write(7249115, 13101856, 4, true)
            memory.write(7249175, 13101856, 4, true)
            memory.write(7249235, 13101856, 4, true)
        else
            memory.write(7249056, 8752012, 4, true)
            memory.write(7249115, 8752012, 4, true)
            memory.write(7249175, 8752012, 4, true)
            memory.write(7249235, 8752012, 4, true)
        end
        checkboxes.waterfixquadro[0] = ini.settings.waterfixquadro
	end
    if fnc == "FixLongArm" or fnc == "all" then
        if ini.settings.longarmfix then
            memory.write(7045634, 33807, 2, true)
            memory.write(7046489, 33807, 2, true)
        else
            memory.write(7045634, 59792, 2, true)
            memory.write(7046489, 59792, 2, true)
        end
        checkboxes.longarmfix[0] = ini.settings.longarmfix
	end
    if fnc == "FixBlackRoads" or fnc == "all" then
        if ini.settings.fixblackroads then
            memory.write(8931716, 0, 4, true)
        else
            memory.write(8931716, 2, 4, true)
        end
        checkboxes.fixblackroads[0] = ini.settings.fixblackroads
	end
    if fnc == "FixSensitivity" or fnc == "all" then
        if ini.settings.sensfix then
            memory.write(5382798, 11987996, 4, true)
            memory.write(5311528, 11987996, 4, true)
            memory.write(5316106, 11987996, 4, true)
        else
            memory.write(5382798, 11987992, 4, true)
            memory.write(5311528, 11987992, 4, true)
            memory.write(5316106, 11987992, 4, true)
        end
        checkboxes.sensfix[0] = ini.settings.sensfix
	end
    if fnc == "AudioStream" or fnc == "all" then
        if get_samp_version() == "r1" then
            if ini.settings.audiostream then
                memory.write(sampGetBase() + 104848, 9449, 2, true)-- AudioStream
            else
                memory.write(sampGetBase() + 104848, 50064, 2, true)-- AudioStream
            end
        elseif get_samp_version() == "r3" then
            if ini.settings.audiostream then
                memory.write(sampGetBase() + 0x661F3, 14708, 2, true)-- AudioStream
            else
                memory.write(sampGetBase() + 0x661F3, 50064, 2, true)-- AudioStream
            end
        end
	end
    if fnc == "InteriorMusic" or fnc == "all" then
        if ini.settings.intmusic then
            memory.write(5276752, -591647351, 4, true)
            memory.write(5276756, 182, 2, true)
            memory.write(5277719, -591647351, 4, true)
            memory.write(5277723, 182, 2, true)
        else
            memory.fill(5276752, 144, 6, true)
            memory.fill(5277719, 144, 6, true)
        end
	end
    if fnc == "NoSounds" or fnc == "all" then
        if ini.settings.sounds then
            callFunction(0x507440, 0, 0)
            writeMemory(0x507750, 1, 86, true)
        else
            callFunction(0x507430, 0, 0)
            writeMemory(0x507750, 1, 0xC3, true)
            local bs = raknetNewBitStream()
            raknetEmulRpcReceiveBitStream(42, bs)
            raknetDeleteBitStream(bs)
        end
    end
    if fnc == "NoRadio" or fnc == "all" then
        if ini.settings.noradio then
            memory.write(5159328, -1947628715, 4, true)
        else
            memory.write(5159328, -1962933054, 4, true)
        end
	end
    if fnc == "BigHPBar" or fnc == "all" then
        if ini.settings.bighpbar then
            memory.setfloat(12030944, 910.4, true)
            save()
        else
            memory.setfloat(12030944, 569.0, true)
            save()
        end
	end
    if fnc == "MapZoom" or fnc == "all" then
        if ini.settings.mapzoom then
            memory.setfloat(5719357, ini.settings.mapzoomvalue, true)
        else
            memory.setfloat(5719357, 1000.0, true)
        end
	end
    if fnc == "AnimationMoney" or fnc == "all" then
        if ini.settings.animmoney == 0 then
            memory.write(5707667, 138, 1, true)
        elseif ini.settings.animmoney == 1 then
            memory.write(5707667, 137, 1, true)
        elseif ini.settings.animmoney == 2 then
            memory.write(5707667, 139, 1, true)
        end
	end
    if fnc == "BlockSampKeys" or fnc == "all" then
        if ini.nop_samp_keys.key_F1 then
            writeMemory(sampGetBase() + ((get_samp_version() == "r1") and 0x713DF+1 or 0x752CF+1), 1, 0, true)--disa f1 0.3.7 R1 original byte 0x70
        else
            writeMemory(sampGetBase() + ((get_samp_version() == "r1") and 0x713DF+1 or 0x752CF+1), 1, 0x70, true)--disa f1 0.3.7 R1 original byte 0x70
        end

       
        if ini.nop_samp_keys.key_F4 then
            memory.setint8(sampGetBase() + ((get_samp_version() == "r1") and 0x797E or 0x79A4), 0, true)
        else
            memory.setint8(sampGetBase() + ((get_samp_version() == "r1") and 0x797E or 0x79A4), 115, true)
        end
        if ini.nop_samp_keys.key_F7 then
            memory.fill(sampGetBase() + ((get_samp_version() == "r1") and 0x5D8AD or 0x60C4D), 0xC3, 1, true)
        else
            memory.write(sampGetBase() + ((get_samp_version() == "r1") and 0x5D8AD or 0x60C4D), 0x8B, 1, true)
        end
        if ini.nop_samp_keys.key_T then
            memory.setint8(sampGetBase() + ((get_samp_version() == "r1") and 0x5DB04 or 0x60EA4), 0xC3, true)
            memory.setint8(sampGetBase() + ((get_samp_version() == "r1") and 0x5DAFA or 0x60E9A), 0xC3, true)
        else
            memory.setint8(sampGetBase() + ((get_samp_version() == "r1") and 0x5DB04 or 0x60EA4), 0x852F7574, true)
            memory.setint8(sampGetBase() + ((get_samp_version() == "r1") and 0x5DAFA or 0x60E9A), 0x900A7490, true)
        end
	end
    if fnc == "NoPlaneLine" or fnc == "all" then
        if ini.settings.noplaneline then
            memory.fill(0x7178F0, 0x90, 5, true)
        else
            memory.hex2bin('E9ABFAFFFF', 0x7178F0, 5)
        end
	end
    if fnc == "NoHealthFlick" or fnc == "all" then
        if ini.settings.nohealthflick then
            writeMemory(0x5892AB, 1, 0, true) --  0 on 10 off
        else
            writeMemory(0x5892AB, 1, 10, true) --  0 on 10 off
        end
    end
    if fnc == "NoTireTracks" or fnc == "all" then
        if ini.settings.tiretracks then
            memory.fill(0x53E175, 0x90, 5, true)
        else
            memory.hex2bin('E8C6241E00', 0x53E175, 5)
        end
    end
    if fnc == "SunFix" or fnc == "all" then
        if ini.settings.sunfix then
            memory.hex2bin("E865041C00", 0x53C136, 5)
        else
            memory.fill(0x53C136, 0x90, 5, true)
        end
        checkboxes.sunfix[0] = ini.settings.sunfix
    end
    if fnc == "TargetBlip" or fnc == "all" then
        if ini.settings.targetblip then
            memory.write(5497324, 116, 1, true)
        else
            memory.write(5497324, 235, 1, true)
        end
    end
    if fnc == "CleanMemory" then
        local oldram = ("%d"):format(tonumber(get_memory()))
        callFunction(0x53C500, 2, 2, 1, 1)
        callFunction(0x40D7C0, 1, 1, -1)
        callFunction(0x53C810, 1, 1, 1)
        callFunction(0x40CF80, 0, 0)
        callFunction(0x4090A0, 0, 0)
        callFunction(0x5A18B0, 0, 0)
        callFunction(0x707770, 0, 0)
        callFunction(0x40CFD0, 0, 0)
        local newram = ("%d"):format(tonumber(get_memory()))
        if ini.cleaner.cleaninfo then
            sampAddChatMessage(script_name.."{FFFFFF} Memoria antes: {dc4747}"..oldram.." MB. {FFFFFF}memoria despues: {dc4747}"..newram.." MB. {FFFFFF}borrado: {dc4747}"..oldram - newram.." MB.", 0x73b461)
        end
    end
    if fnc == "Vsync" or fnc == "all" then
        if not doesFileExist(getGameDirectory()..'\\_CoreGame.asi') then
            if ini.settings.vsync then
                memory.write(0xBA6794, 1, 1, true)
            else
                memory.write(0xBA6794, 0, 1, true)
            end
        end
    end
    if fnc == "RadarColorFix" or fnc == "all" then
        if ini.settings.radar_color_fix then
            memory.write(0x58A798, 255, 1, true)
            memory.write(0x58A790, 255, 1, true)
            memory.write(0x58A78E, 255, 1, true)
            memory.write(0x58A89A, 255, 1, true)
            memory.write(0x58A896, 255, 1, true)
            memory.write(0x58A894, 255, 1, true)
            memory.write(0x58A8EE, 255, 1, true)
            memory.write(0x58A8E6, 255, 1, true)
            memory.write(0x58A8DE, 255, 1, true)
            memory.write(0x58A9A2, 255, 1, true)
            memory.write(0x58A99A, 255, 1, true)
            memory.write(0x58A996, 255, 1, true)
        else
            memory.write(0x58A798, 0, 1, true)
            memory.write(0x58A790, 0, 1, true)
            memory.write(0x58A78E, 0, 1, true)
            memory.write(0x58A89A, 0, 1, true)
            memory.write(0x58A896, 0, 1, true)
            memory.write(0x58A894, 0, 1, true)
            memory.write(0x58A8EE, 0, 1, true)
            memory.write(0x58A8E6, 0, 1, true)
            memory.write(0x58A8DE, 0, 1, true)
            memory.write(0x58A9A2, 0, 1, true)
            memory.write(0x58A99A, 0, 1, true)
            memory.write(0x58A996, 0, 1, true)
        end
    end
    if fnc == "Radarfix" or fnc == "all" then
        if ini.settings.radarfix then
            memory.setfloat(8809336, ini.settings.radarHeight, true)--altura del radar X
            memory.setfloat(8809332, ini.settings.radarWidth, true)--altura del radar Y
            memory.setfloat(8751632, ini.settings.radarPosX, true)--posición del radar X
            memory.setfloat(8809328, ini.settings.radarPosY, true)--posición del radar Y
            ---------------- [fix bug edit pos elements] ----------------
            memory.write(5828441, 9263116, 4, true)
            memory.write(5828895, 9263116, 4, true)
            memory.write(7422387, 5108644, 4, true)
            memory.write(7422456, 5108644, 4, true)
            memory.write(7441684, 5108644, 4, true)
            -------------------------------------------------------------
        else
            memory.setfloat(8809336, 94.0, true)--altura del radar X
            memory.setfloat(8809332, 76.0, true)--altura del radar Y
            memory.setfloat(8751632, 40.0, true)--posición del radar X
            memory.setfloat(8809328, 104.0, true)--posición del radar Y
        end
        checkboxes.radarfix[0] = ini.settings.radarfix
    end
    if fnc == "ForceAniso" or fnc == "all" then
        if ini.settings.forceaniso then
            if readMemory(0x730F9C, 1, true) ~= 0 then
                memory.write(0x730F9C, 0, 1, true)-- force aniso
                loadScene(20000000, 20000000, 20000000)
                callFunction(0x40D7C0, 1, 1, -1)
            end
        else
            if readMemory(0x730F9C, 1, true) ~= 1 then
                memory.write(0x730F9C, 1, 1, true)-- force aniso
                loadScene(20000000, 20000000, 20000000)
                callFunction(0x40D7C0, 1, 1, -1)
            end
        end
        checkboxes.forceaniso[0] = ini.settings.forceaniso
    end
    if fnc == "SetBrightness" or fnc == "all" then
        memory.setint32(0xBA6784, ini.settings.brightness, true)
        local brightness = cast("float", readMemory(0xBA6784, 4, true) * 0.001953125)
        local CGamma__setGamma = cast("char (__thiscall*)(void*, float, char)", 0x747200)
        CGamma__setGamma(cast("void*", 0xC92134), brightness, true)
    end
    if fnc == "NoLimitMoneyHud" or fnc == "all" then
        if ini.settings.nolimitmoneyhud then
            writeMemory(0x571784, 4, 0x57C7FFF, true)
            writeMemory(0x57179C, 4, 0x57C7FFF, true)
        else
            writeMemory(0x571784, 4, 0x57C3B9A, true)
            writeMemory(0x57179C, 4, 0x57C3B9A, true)
        end
    end
    if fnc == "MoneyZeroFix" or fnc == "all" then
        if ini.settings.moneyzerofix then
            memory.copy(0x866C94, memory.strptr('$%d'), 6, true)
            memory.copy(0x866C8C, memory.strptr('-$%d'), 6, true)
        else
            memory.copy(0x866C94, memory.strptr('$%08d'), 6, true)
            memory.copy(0x866C8C, memory.strptr('-$%08d'), 6, true)
        end
    end
    if fnc == "RadrarNorth" or fnc == "all" then
        if ini.settings.radrarnorth then
            memory.fill(0x588188, 0x90, 5, true)
        else
            memory.hex2bin('E863DEFFFF', 0x588188, 5)
        end
    end
    if fnc == "SetDistObjects" or fnc == "all" then
        local obj_list = {
            stolbs_and_fonars = {
                [1] = { id = 1283, sdist = 85 },
                [2] = { id = 1262, sdist = 45 },
                [3] = { id = 3516, sdist = 85 },
                [4] = { id = 3855, sdist = 50 },
                [5] = { id = 1278, sdist = 150 },
                [6] = { id = 1290, sdist = 150 },
                [7] = { id = 1307, sdist = 100 },
                [8] = { id = 1308, sdist = 100 },
                [9] = { id = 3459, sdist = 100 },
                [10] = { id = 3463, sdist = 62 },
                [11] = { id = 3503, sdist = 50 },
                [12] = { id = 3854, sdist = 100 },
                [13] = { id = 1226, sdist = 62 },
                [14] = { id = 1223, sdist = 53 },
                [15] = { id = 1231, sdist = 55 },
                [16] = { id = 1232, sdist = 55 },
                [17] = { id = 1284, sdist = 85 },
                [18] = { id = 1294, sdist = 55 },
                [19] = { id = 1315, sdist = 64 },
                [20] = { id = 1350, sdist = 60 },
                [21] = { id = 3853, sdist = 62 },
                [22] = { id = 3875, sdist = 100 },
                [23] = { id = 3460, sdist = 62 },
                [24] = { id = 1297, sdist = 59 },
            },
            musor = {
                [1] = { id = 1265, sdist = 45 },
                [2] = { id = 1440, sdist = 50 },
                [3] = { id = 1230, sdist = 40 },
                [4] = { id = 1438, sdist = 50 },
                [5] = { id = 1220, sdist = 40 },
                [6] = { id = 1221, sdist = 40 },
                [7] = { id = 1264, sdist = 45 },
                [8] = { id = 1224, sdist = 41 },
                [9] = { id = 910, sdist = 30 },
                [10] = { id = 926, sdist = 30 },
                [11] = { id = 928, sdist = 30 },
            },
        }
        if ini.settings.givemedistobj then
            for k, v in pairs(obj_list.stolbs_and_fonars) do
                memory.setfloat(getMDO(obj_list.stolbs_and_fonars[k]["id"]), ini.settings.distobjects_stolb_fonars, true)
            end
            for k, v in pairs(obj_list.musor) do
                memory.setfloat(getMDO(obj_list.musor[k]["id"]), ini.settings.distobjects_musor, true)
            end
        else
            for k, v in pairs(obj_list.stolbs_and_fonars) do
                memory.setfloat(getMDO(obj_list.stolbs_and_fonars[k]["id"]), obj_list.stolbs_and_fonars[k]["sdist"], true)
            end
            for k, v in pairs(obj_list.musor) do
                memory.setfloat(getMDO(obj_list.musor[k]["id"]), obj_list.musor[k]["sdist"], true)
            end
        end
    end
    if fnc == "MenuImage" or fnc == "all" then
        if ini.settings.fullmenuimage then
            memory.setfloat(0x57B7EF, ini.settings.fullmenuwidth, true)
            memory.setfloat(0x57B80B, ini.settings.fullmenuheight, true)
            memory.setfloat(0x57B852, ini.settings.fullmenuwidth, true)
            memory.setfloat(0x57B862, ini.settings.fullmenuheight, true)
            memory.setfloat(0x57B877, ini.settings.fullmenuwidth, true)
            memory.setfloat(0x57B88F, 320.0, true)
            memory.setfloat(0x57B8A9, ini.settings.fullmenuwidth, true)
            memory.setfloat(0x57B8BD, ini.settings.fullmenuwidth, true)
            memory.setfloat(0x57B8D5, ini.settings.fullmenuheight, true)
            memory.setfloat(0x57B917, ini.settings.fullmenuwidth, true)
            memory.setfloat(0x57B927, ini.settings.fullmenuheight, true)
        else
            memory.setfloat(0x57B7EF, 256.0, true)
            memory.setfloat(0x57B80B, 256.0, true)
            memory.setfloat(0x57B852, 256.0, true)
            memory.setfloat(0x57B862, 256.0, true)
            memory.setfloat(0x57B877, 128.0, true)
            memory.setfloat(0x57B88F, 128.0, true)
            memory.setfloat(0x57B8A9, 256.0, true)
            memory.setfloat(0x57B8BD, 256.0, true)
            memory.setfloat(0x57B8D5, 256.0, true)
            memory.setfloat(0x57B917, 300.0, true)
            memory.setfloat(0x57B927, 200.0, true)
        end
    end
    if fnc == "FixBloodWood" or fnc == "all" then
        if ini.settings.fixbloodwood then
            writeMemory(0x49EE63+1, 4, 0, true)--fix blood wood
        else
            writeMemory(0x49EE63+1, 4, 0x3F800000, true)--fix blood wood
        end
    end
    if fnc == "EditCrosshair" or fnc == "all" then
        crx[0] = ini.settings.crosshairX
        cry[0] = ini.settings.crosshairY
        ffi.cast('float**', 0x58E307)[0] = crx
        ffi.cast('float**', 0x58E321)[0] = cry
    end
    if fnc == "SmallIconsRadar" or fnc == "all" then
        local sizeiconmap = {
            [1] = { mem = 0x586047, nmem = 0xCB0650, val = ini.settings.osnov_icon, sval = 8.0 }, --Iconos
            [2] = { mem = 0x586060, nmem = 0xCB0655, val = ini.settings.osnov_icon, sval = 8.0 }, --Iconos
            [3] = { mem = 0x584192, nmem = 0xCB0665, val = 0.0015625 / ini.settings.quadro_icon_size, sval = 0.0015625 }, -- X  Jugadores cuadrados
            [4] = { mem = 0x5841B2, nmem = 0xCB0670, val = 0.00203125 /ini.settings.quadro_icon_size, sval = 0.00203125 }, -- Y Jugadores cuadrados
            [5] = { mem = 0x58410D, nmem = 0xCB0675, val = 0.0016471354 / ini.settings.quadro_icon_border, sval = 0.0016471354}, -- Trazo X Cuadrado Jugadores
            [6] = { mem = 0x58412D, nmem = 0xCB0680, val = 0.00214843762 / ini.settings.quadro_icon_border, sval = 0.00214843762}, -- Stroke Y Cuadrado Jugadores
            [7] = { mem = 0x5842E8, nmem = 0xCB0685, val = 0.0015625 / ini.settings.trianglen_icon_size, sval = 0.0015625 }, -- Triángulo jugadores abajo X
            [8] = { mem = 0x5842C8, nmem = 0xCB0690, val = 0.00203125 / ini.settings.trianglen_icon_size, sval = 0.00203125 }, -- Triángulo jugadores abajo Y
            [9] = { mem = 0x58424B, nmem = 0xCB0695, val = 0.0016471354 / ini.settings.trianglen_icon_border, sval = 0.0016471354}, -- Stroke X jugadores triangulares hacia abajo
            [10] = { mem = 0x584209, nmem = 0xCB0700, val = 0.00214843762 / ini.settings.trianglen_icon_border, sval = 0.00214843762}, -- Stroke Y jugadores triangulares hacia abajo
            [11] = { mem = 0x584436, nmem = 0xCB0705, val = 0.0015625 / ini.settings.trianglev_icon_size, sval = 0.0015625 }, -- Triángulo Jugadores Top X
            [12] = { mem = 0x58440E, nmem = 0xCB0710, val = 0.00203125 / ini.settings.trianglev_icon_size, sval = 0.00203125}, -- Triángulo jugadores encima de Y
            [13] = { mem = 0x58439E, nmem = 0xCB0715, val = 0.0016471354 / ini.settings.trianglev_icon_border, sval = 0.0016471354}, -- Jugadores triangulares hasta Stroke X
            [14] = { mem = 0x584348, nmem = 0xCB0720, val = 0.00214843762 / ini.settings.trianglev_icon_border, sval = 0.00214843762}, -- Jugadores triangulares arriba Trazo Y
            [15] = { mem = 0x5886DC, nmem = 0xCB0725, val = ini.settings.player_icon_size, sval = 7.5 }, --jugador en el mapa
        }
        if ini.settings.smalliconsradar then
            for i = 1, #sizeiconmap do
                memory.setfloat(sizeiconmap[i]["nmem"], sizeiconmap[i]["val"], true)-- escribir valor en la memoria libre
                memory.write(sizeiconmap[i]["mem"], sizeiconmap[i]["nmem"], 4, true)--convertir a memoria libre
            end
        else
            for i = 1, #sizeiconmap do
                memory.setfloat(sizeiconmap[i]["nmem"], sizeiconmap[i]["sval"], true)-- escribir valor en la memoria libre
                memory.write(sizeiconmap[i]["mem"], sizeiconmap[i]["nmem"], 4, true)--convertir a memoria libre
            end
        end
    end
    if fnc == "SetDistLodVeh" or fnc == "all" then
        memory.setfloat(0xCB0900, ini.settings.vehloddist, true)
        memory.write(0x732924+2, 0xCB0900, 4, true)
    end
    if fnc == "HelpText" or fnc == "all" then
        if ini.settings.helptext then
            memory.fill(0x57E3AE, 0x90, 5, true)-- consejos
        else
            memory.hex2bin("E86DC41900", 0x57E3AE, 5)
        end
    end
    if fnc == "TreePitching" or fnc == "all" then
        if ini.settings.treepitching then
            memory.fill(0x535030, 0x90, 5, true) -- disable wind effects
        else
            memory.hex2bin("E8DBB82B00", 0x535030, 5)
        end
    end
    if fnc == "UgenrlMode" or fnc == "all" then
        if ini.ugenrl_main.enable then
            if ini.ugenrl_main.mode == 0 then
                memory.hex2bin("752D", 0x503D34, 2)
                callFunction(0x507430, 0, 0)
                writeMemory(0x507750, 1, 0xC3, true)
                local bs = raknetNewBitStream()
                raknetEmulRpcReceiveBitStream(42, bs)
                raknetDeleteBitStream(bs)
            elseif ini.ugenrl_main.mode == 1 then
                memory.fill(0x503D34, 0x90, 2, true)
                callFunction(0x507440, 0, 0)
                writeMemory(0x507750, 1, 86, true)
            elseif ini.ugenrl_main.mode == 2 then
                memory.hex2bin("752D", 0x503D34, 2)
                callFunction(0x507440, 0, 0)
                writeMemory(0x507750, 1, 86, true)
            end
        end
    end
    if fnc == "MoneyBorder" or fnc == "all" then
        writeMemory(0x58F58D, 1, ini.settings.fontmoneyborder, true)
    end
    if fnc == "Recolorer" or fnc == "all" then
        if ini.settings.recolorer then
            memory.write(0xBAB22C, ("0xFF%06X"):format(join_argb(0, ini.RECOLORER_HEALTH.b*255, ini.RECOLORER_HEALTH.g*255, ini.RECOLORER_HEALTH.r*255)), 4, false)
            memory.write(0xBAB230, ("0xFF%06X"):format(join_argb(0, ini.RECOLORER_MONEY.b*255, ini.RECOLORER_MONEY.g*255, ini.RECOLORER_MONEY.r*255)), 4, false)
            memory.write(0xBAB244, ("0xFF%06X"):format(join_argb(0, ini.RECOLORER_STARS.b*255, ini.RECOLORER_STARS.g*255, ini.RECOLORER_STARS.r*255)), 4, false)
            memory.write(0xBAB23C, ("0xFF%06X"):format(join_argb(0, ini.RECOLORER_ARMOUR.b*255, ini.RECOLORER_ARMOUR.g*255, ini.RECOLORER_ARMOUR.r*255)), 4, false)
            memory.write(0xBAB238, ("0xFF%06X"):format(join_argb(0, ini.RECOLORER_PATRONS.b*255, ini.RECOLORER_PATRONS.g*255, ini.RECOLORER_PATRONS.r*255)), 4, false)

            memory.setuint32(sampGetBase() + ((get_samp_version() == "r1") and 0x68B0C or 0x6CA7C), ("0xFF%06X"):format(join_argb(0, ini.RECOLORER_PLAYERHEALTH.r*255, ini.RECOLORER_PLAYERHEALTH.g*255, ini.RECOLORER_PLAYERHEALTH.b*255)), true) -- tira completa
            memory.setuint32(sampGetBase() + ((get_samp_version() == "r1") and 0x68B33 or 0x6CAA3), ("0xFF%06X"):format(join_argb(0, ini.RECOLORER_PLAYERHEALTH2.r*255, ini.RECOLORER_PLAYERHEALTH2.g*255, ini.RECOLORER_PLAYERHEALTH2.b*255)), true) -- fondo

            memory.setuint32(sampGetBase() + ((get_samp_version() == "r1") and 0x68DD5 or 0x6CD45), ("0xFF%06X"):format(join_argb(0, ini.RECOLORER_PLAYERARMOR.r*255, ini.RECOLORER_PLAYERARMOR.g*255, ini.RECOLORER_PLAYERARMOR.b*255)), true) -- barra completa de armadura
            memory.setuint32(sampGetBase() + ((get_samp_version() == "r1") and 0x68E00 or 0x6CD70), ("0xFF%06X"):format(join_argb(0, ini.RECOLORER_PLAYERARMOR2.r*255, ini.RECOLORER_PLAYERARMOR2.g*255, ini.RECOLORER_PLAYERARMOR2.b*255)), true) -- fondo
        else
            writeMemory(0xBAB22C, 4, -14870092, true)
            writeMemory(0xBAB230, 4, -13866954, true)
            writeMemory(0xBAB244, 4, -15703408, true)
            writeMemory(0xBAB23C, 4, -1973791, true)
            writeMemory(0xBAB238, 4, -930900, true)

            writeMemory(sampGetBase() + ((get_samp_version() == "r1") and 0x68B0C or 0x6CA7C), 4, -2088157, true)
            writeMemory(sampGetBase() + ((get_samp_version() == "r1") and 0x68B33 or 0x6CAA3), 4, -2109489, true)
        end
    end
    if fnc == "AntiCrash" or fnc == "all" then
        if ini.settings.anticrash then
            if get_samp_version() == "r1" then
                local base = sampGetBase() + 0x5CF2C
                writeMemory(base, 4, 0x90909090, true)
                base = base + 4
                writeMemory(base, 1, 0x90, true)
                base = base + 9
                writeMemory(base, 4, 0x90909090, true)
                base = base + 4
                writeMemory(base, 1, 0x90, true)
            elseif get_samp_version() == "r3" then
                local base = sampGetBase() + 0x602CC
                writeMemory(base, 4, 0x90909090, true)
                base = base + 4
                writeMemory(base, 1, 0x90, true)
                base = base + 9
                writeMemory(base, 4, 0x90909090, true)
                base = base + 4
                writeMemory(base, 1, 0x90, true)
            end
        end
    end
end


------------------------------------
function imgui.NewInputText(lable, val, width, hint, hintpos)
    local hint = hint and hint or ''
    local hintpos = tonumber(hintpos) and tonumber(hintpos) or 1
    local cPos = imgui.GetCursorPos()
    imgui.PushItemWidth(width)
    local result = imgui.InputText(lable, val, sizeof(val))
    if #str(val) == 0 then
        local hintSize = imgui.CalcTextSize(hint)
        if hintpos == 2 then imgui.SameLine(cPos.x + (width - hintSize.x) / 2)
        elseif hintpos == 3 then imgui.SameLine(cPos.x + (width - hintSize.x - 5))
        else imgui.SameLine(cPos.x + 5) end
        imgui.TextColored(imgui.ImVec4(1.00, 1.00, 1.00, 0.40), tostring(hint))
    end
    imgui.PopItemWidth()
    return result
end

function imgui.Link(link, text)
    text = text or link
    local tSize = imgui.CalcTextSize(text)
    local p = imgui.GetCursorScreenPos()
    local DL = imgui.GetWindowDrawList()
    local col = { imgui.GetColorU32Vec4(imgui.GetStyle().Colors[imgui.Col.Button]), imgui.GetColorU32Vec4(imgui.GetStyle().Colors[imgui.Col.ButtonHovered]) }
    if imgui.InvisibleButton("##" .. link, tSize) then os.execute("explorer " .. link) end
    local color = imgui.IsItemHovered() and col[1] or col[2]
    DL:AddText(p, color, text)
    DL:AddLine(imgui.ImVec2(p.x, p.y + tSize.y), imgui.ImVec2(p.x + tSize.x, p.y + tSize.y), color)
end

-- labels - Array - Nombres de los elementos del menú
-- selected - imgui.ImInt() - elemento de menú seleccionado
-- size - imgui.ImVec2() - tamaño del elemento
-- speed - float - velocidad de animación de selección de elementos (opcional, el valor predeterminado es 0.2)
-- centering - bool - Centrar el texto en el elemento (opcional, el valor predeterminado es falso)
function imgui.CustomMenu(labels, selected, size, speed, centering)
    local bool = false
    speed = speed and speed or 0.500
    local radius = size.y * 0.50
    local draw_list = imgui.GetWindowDrawList()
    if LastActiveTime == nil then LastActiveTime = {} end
    if LastActive == nil then LastActive = {} end
    local function ImSaturate(f)
        return f < 0.0 and 0.0 or (f > 1.0 and 1.0 or f)
    end
    for i, v in ipairs(labels) do
        local c = imgui.GetCursorPos()
        local p = imgui.GetCursorScreenPos()
        if imgui.InvisibleButton(v..'##'..i, size) then
            selected[0] = i
            LastActiveTime[v] = os.clock()
            LastActive[v] = true
            bool = true
        end
        imgui.SetCursorPos(c)
        local t = selected[0] == i and 1.0 or 0.0
        if LastActive[v] then
            local time = os.clock() - LastActiveTime[v]
            if time <= 0.3 then
                local t_anim = ImSaturate(time / speed)
                t = selected[0] == i and t_anim or 1.0 - t_anim
            else
                LastActive[v] = false
            end
        end
        if ini.settings.theme == 1 then
            local col_bg = imgui.GetColorU32Vec4(selected[0] == i and imgui.ImVec4(0.10, 0.10, 0.10, 0.60) or imgui.ImVec4(0,0,0,0))
            local col_box = imgui.GetColorU32Vec4(selected[0] == i and imgui.ImVec4(icolors.ActiveText[0], icolors.ActiveText[1], icolors.ActiveText[2], icolors.ActiveText[3]) or imgui.ImVec4(0,0,0,0))
            local col_hovered = imgui.GetStyle().Colors[imgui.Col.ButtonHovered]
            local col_hovered = imgui.GetColorU32Vec4(imgui.ImVec4(col_hovered.x, col_hovered.y, col_hovered.z, (imgui.IsItemHovered() and 0.2 or 0)))
            
            if selected[0] == i then draw_list:AddRectFilledMultiColor(imgui.ImVec2(p.x-size.x/6, p.y), imgui.ImVec2(p.x + (radius * 0.65) + t * size.x, p.y + size.y), imgui.GetColorU32Vec4(imgui.ImVec4(icolors.PLeftUp[0], icolors.PLeftUp[1], icolors.PLeftUp[2], icolors.PLeftUp[3])), imgui.GetColorU32Vec4(imgui.ImVec4(icolors.PRightUp[0], icolors.PRightUp[1], icolors.PRightUp[2], icolors.PRightUp[3])), imgui.GetColorU32Vec4(imgui.ImVec4(icolors.PRightDown[0], icolors.PRightDown[1], icolors.PRightDown[2], icolors.PRightDown[3])), imgui.GetColorU32Vec4(imgui.ImVec4(icolors.PLeftDown[0], icolors.PLeftDown[1], icolors.PLeftDown[2], icolors.PLeftDown[3]))) end
            draw_list:AddRectFilled(imgui.ImVec2(p.x-size.x/6, p.y), imgui.ImVec2(p.x + (radius * 0.65) + size.x, p.y + size.y), col_hovered, 0.0)
            imgui.SetCursorPos(imgui.ImVec2(c.x+(centering and (size.x-imgui.CalcTextSize(v).x)/2 or 15), c.y+(size.y-imgui.CalcTextSize(v).y)/2))
            if selected[0] == i then 
                imgui.TextColored(imgui.ImVec4(icolors.ActiveText[0], icolors.ActiveText[1], icolors.ActiveText[2], icolors.ActiveText[3]), v)
            else
                imgui.TextColored(imgui.ImVec4(icolors.PassiveText[0], icolors.PassiveText[1], icolors.PassiveText[2], icolors.PassiveText[3]), v)
            end
            draw_list:AddRectFilled(imgui.ImVec2(p.x, p.y), imgui.ImVec2(p.x+3.5, p.y + size.y), col_box)
            imgui.SetCursorPos(imgui.ImVec2(c.x, c.y+size.y))
        else
            local col_bg = imgui.GetColorU32Vec4(selected[0] == i and imgui.ImVec4(0.10, 0.10, 0.10, 0.60) or imgui.ImVec4(0,0,0,0))
            local col_box = imgui.GetColorU32Vec4(selected[0] == i and imgui.GetStyle().Colors[imgui.Col.ButtonHovered] or imgui.ImVec4(0,0,0,0))
            local col_hovered = imgui.GetStyle().Colors[imgui.Col.ButtonHovered]
            local col_hovered = imgui.GetColorU32Vec4(imgui.ImVec4(col_hovered.x, col_hovered.y, col_hovered.z, (imgui.IsItemHovered() and 0.2 or 0)))
            
            if selected[0] == i then draw_list:AddRectFilledMultiColor(imgui.ImVec2(p.x-size.x/6, p.y), imgui.ImVec2(p.x + (radius * 0.65) + t * size.x, p.y + size.y), imgui.GetColorU32Vec4(imgui.GetStyle().Colors[imgui.Col.Button]), imgui.GetColorU32Vec4(imgui.ImVec4(0,0,0,0)), imgui.GetColorU32Vec4(imgui.ImVec4(0,0,0,0)), imgui.GetColorU32Vec4(imgui.GetStyle().Colors[imgui.Col.Button])) end
            draw_list:AddRectFilled(imgui.ImVec2(p.x-size.x/6, p.y), imgui.ImVec2(p.x + (radius * 0.65) + size.x, p.y + size.y), col_hovered, 0.0)
            imgui.SetCursorPos(imgui.ImVec2(c.x+(centering and (size.x-imgui.CalcTextSize(v).x)/2 or 15), c.y+(size.y-imgui.CalcTextSize(v).y)/2))
            if selected[0] == i then 
                imgui.TextColored(imgui.GetStyle().Colors[imgui.Col.ButtonHovered], v)
            else
                imgui.TextColored(imgui.ImVec4(0.60, 0.60, 0.60, 0.60), v)
            end
            draw_list:AddRectFilled(imgui.ImVec2(p.x, p.y), imgui.ImVec2(p.x+3.5, p.y + size.y), col_box)
            imgui.SetCursorPos(imgui.ImVec2(c.x, c.y+size.y))
        end
    end
    return bool
end

function imgui.CustomSelectable(labels, selected, size, speed, centering)
    local bool = false
    speed = speed and speed or 0.500
    local radius = size.y * 0.50
    local draw_list = imgui.GetWindowDrawList()
    if LastActiveTime == nil then LastActiveTime = {} end
    if LastActive == nil then LastActive = {} end
    local function ImSaturate(f)
        return f < 0.0 and 0.0 or (f > 1.0 and 1.0 or f)
    end
    for i, v in ipairs(labels) do
        local c = imgui.GetCursorPos()
        local p = imgui.GetCursorScreenPos()
        if imgui.InvisibleButton(v..'##'..i, size) then
            selected[0] = i
            LastActiveTime[v] = os.clock()
            LastActive[v] = true
            bool = true
        end
        imgui.SetCursorPos(c)
        local t = selected[0] == i and 1.0 or 0.0
        if LastActive[v] then
            local time = os.clock() - LastActiveTime[v]
            if time <= 0.3 then
                local t_anim = ImSaturate(time / speed)
                t = selected[0] == i and t_anim or 1.0 - t_anim
            else
                LastActive[v] = false
            end
        end
            local col_bg = imgui.GetColorU32Vec4(selected[0] == i and imgui.ImVec4(0.10, 0.10, 0.10, 0.60) or imgui.ImVec4(0,0,0,0))
            local col_box = imgui.GetColorU32Vec4(selected[0] == i and imgui.ImVec4(icolors.ActiveText[0], icolors.ActiveText[1], icolors.ActiveText[2], icolors.ActiveText[3]) or imgui.ImVec4(0,0,0,0))
            local col_hovered = imgui.GetStyle().Colors[imgui.Col.ButtonHovered]
            local col_hovered = imgui.GetColorU32Vec4(imgui.ImVec4(col_hovered.x, col_hovered.y, col_hovered.z, (imgui.IsItemHovered() and 0.2 or 0)))
            
            if selected[0] == i then draw_list:AddRectFilledMultiColor(imgui.ImVec2(p.x-size.x/6, p.y), imgui.ImVec2(p.x + (radius * 0.65) + t * size.x, p.y + size.y), imgui.GetColorU32Vec4(imgui.GetStyle().Colors[imgui.Col.CheckMark]), imgui.GetColorU32Vec4(imgui.ImVec4(0,0,0,0)), imgui.GetColorU32Vec4(imgui.ImVec4(0,0,0,0)), imgui.GetColorU32Vec4(imgui.GetStyle().Colors[imgui.Col.CheckMark])) end
            --if selected[0] == i then draw_list:AddRectFilled(imgui.ImVec2(p.x-size.x, p.y), imgui.ImVec2(p.x + size.x, p.y + size.y), imgui.GetColorU32Vec4(imgui.GetStyle().Colors[imgui.Col.Button]), 0.0) end
            draw_list:AddRectFilled(imgui.ImVec2(p.x-size.x/6, p.y), imgui.ImVec2(p.x + size.x, p.y + size.y), col_hovered, 0.0)
            imgui.SetCursorPos(imgui.ImVec2(c.x+(centering and (size.x-imgui.CalcTextSize(v).x)/2 or 15), c.y+(size.y-imgui.CalcTextSize(v).y)/2))
            imgui.TextColored(imgui.ImVec4(imgui.GetStyle().Colors[imgui.Col.Text]), v)
            --draw_list:AddRectFilled(imgui.ImVec2(p.x, p.y), imgui.ImVec2(p.x+3.5, p.y + size.y), col_box)
            imgui.SetCursorPos(imgui.ImVec2(c.x, c.y+size.y))
    end
    return bool
end


function imgui.BeginTitleChild(str_id, size, rounding, offset, panelBool)
    imgui.SetCursorPosY(imgui.GetCursorPosY()+20)
    if panelBool == nil then panelBool = true end
    panelBool = panelBool and true or false
    offset = offset or 50
    local DL = imgui.GetWindowDrawList()
    local posS = imgui.GetCursorScreenPos()
    local title = str_id:gsub('##.+$', '')
    local sizeT = imgui.CalcTextSize(title)
    local bgColor = imgui.GetStyle().Colors[imgui.Col.Button]
    local bgColor = imgui.GetColorU32Vec4(imgui.ImVec4(bgColor.x, bgColor.y, bgColor.z, 1.0))
    imgui.PushStyleColor(imgui.Col.ChildBg, imgui.ImVec4(0, 0, 0, 0))
    imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0, 0, 0, 0))
    imgui.PushStyleVarFloat(imgui.StyleVar.ChildRounding, rounding)
    imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0, 0, 0, 0))
    imgui.BeginChild(str_id, size, true)
    imgui.PopStyleVar(1)
    imgui.Spacing()
    imgui.PopStyleColor(3)
    size.x = size.x == -1.0 and imgui.GetWindowWidth() or size.x
    size.y = size.y == -1.0 and imgui.GetWindowHeight() or size.y
    if not panelBool then DL:AddRect(posS, imgui.ImVec2(posS.x + size.x, posS.y + size.y), bgColor, rounding, 11+4, 1.6) end
    if panelBool == true then DL:AddRect(posS, imgui.ImVec2(posS.x + size.x, posS.y + size.y), bgColor, rounding, 7+5, 1.6)
    DL:AddRectFilled(imgui.ImVec2(posS.x, posS.y - 25), imgui.ImVec2(posS.x + size.x, posS.y + size.x/size.y ), bgColor, rounding, 3)
    
    DL:AddText(imgui.ImVec2(posS.x + offset, posS.y - 10 - (sizeT.y / 2)), imgui.GetColorU32Vec4(imgui.GetStyle().Colors[imgui.Col.Text]), title) end
end

CloseButton = function(str_id, value, rounding)
	size = size or 23
	rounding = rounding or 5
	local DL = imgui.GetWindowDrawList()
	local p = imgui.GetCursorScreenPos()
	
	local result = imgui.InvisibleButton(str_id, imgui.ImVec2(size, size))
	if result then
		value[0] = false
	end
	local hovered = imgui.IsItemHovered()

    local col = imgui.GetColorU32Vec4(hovered and imgui.GetStyle().Colors[imgui.Col.Text] or imgui.GetStyle().Colors[imgui.Col.ButtonHovered])
	local col_bg = imgui.ColorConvertFloat4ToU32(imgui.GetStyle().Colors[imgui.Col.FrameBg])
	local offs = (size / 4.2)

	DL:AddRectFilled(p, imgui.ImVec2(p.x + size+1, p.y + size), col_bg, rounding, 5)
	DL:AddLine(
		imgui.ImVec2(p.x + offs, p.y + offs), 
		imgui.ImVec2(p.x + size - offs, p.y + size - offs), 
		col,
		size / 10
	)
	DL:AddLine(
		imgui.ImVec2(p.x + size - offs, p.y + offs), 
		imgui.ImVec2(p.x + offs, p.y + size - offs),
		col,
		size / 10
	)
	return result
end

function imgui.Hint(text, delay, action)
    if imgui.IsItemHovered() then
        if go_hint == nil then go_hint = os.clock() + (delay and delay or 0.0) end
        local alpha = (os.clock() - go_hint) * 5
        if os.clock() >= go_hint then
            imgui.PushStyleVarVec2(imgui.StyleVar.WindowPadding, imgui.ImVec2(10, 10))
            imgui.PushStyleVarFloat(imgui.StyleVar.Alpha, (alpha <= 1.0 and alpha or 1.0))
                imgui.PushStyleColor(imgui.Col.PopupBg, imgui.ImVec4(0.11, 0.11, 0.11, 1.00))
                    imgui.BeginTooltip()
                    imgui.PushTextWrapPos(450)
                    imgui.PushFont(fonts[15])
                    imgui.TextColored(imgui.GetStyle().Colors[imgui.Col.ButtonHovered], u8' Descripción:')
                    imgui.PopFont()
                    imgui.TextUnformatted(text)
                    if action ~= nil then
                        imgui.TextColored(imgui.GetStyle().Colors[imgui.Col.TextDisabled], '\n '..action)
                    end
                    if not imgui.IsItemVisible() and imgui.GetStyle().Alpha == 1.0 then go_hint = nil end
                    imgui.PopTextWrapPos()
                    imgui.EndTooltip()
                imgui.PopStyleColor()
            imgui.PopStyleVar(2)
        end
    end
end

function Im_Update()
	local i = NUMWEATHERS * CTimeCycle.GetCurrentHourTimeId() + CurrWeather[0]
	Im.Hours 					= new.int(Hours[0])
	Im.Mins 					= new.int(Minutes[0])
	Im.Seconds 					= new.int(Seconds[0])
	Im.TimeScale 				= new.int(TimeScale[0])
	Im.AmbRGB 					= imgui.new.float[3](CTimeCycle.m_nAmbientRed[i] /255, CTimeCycle.m_nAmbientGreen[i] /255, CTimeCycle.m_nAmbientBlue[i] /255)
	Im.AmbObjRGB 				= imgui.new.float[3](CTimeCycle.m_nAmbientRed_Obj[i] / 255, CTimeCycle.m_nAmbientGreen_Obj[i] / 255, CTimeCycle.m_nAmbientBlue_Obj[i] / 255)
	Im.SkyTopRGB 				= imgui.new.float[3](CTimeCycle.m_nSkyTopRed[i] / 255, CTimeCycle.m_nSkyTopGreen[i] / 255, CTimeCycle.m_nSkyTopBlue[i] / 255)
	Im.SkyBottomRGB 			= imgui.new.float[3](CTimeCycle.m_nSkyBottomRed[i] / 255, CTimeCycle.m_nSkyBottomGreen[i] / 255, CTimeCycle.m_nSkyBottomBlue[i] / 255)
	Im.SunCoreRGB 				= imgui.new.float[3](CTimeCycle.m_nSunCoreRed[i] / 255, CTimeCycle.m_nSunCoreGreen[i] / 255, CTimeCycle.m_nSunCoreBlue[i] / 255)
	Im.SunCoronaRGB 			= imgui.new.float[3](CTimeCycle.m_nSunCoronaRed[i] / 255, CTimeCycle.m_nSunCoronaGreen[i] / 255, CTimeCycle.m_nSunCoronaBlue[i] / 255)
	Im.SunSz 					= new.int(CTimeCycle.m_fSunSize[i])
	Im.SpriteSz 				= new.int(CTimeCycle.m_fSpriteSize[i])
	Im.SpriteBrght 				= new.int(CTimeCycle.m_fSpriteBrightness[i])
	Im.ShadowStr 				= new.int(CTimeCycle.m_nShadowStrength[i])
	Im.PoleShadowStr 			= new.int(CTimeCycle.m_nPoleShadowStrength[i])
	Im.LightShadowStrength 		= new.int(CTimeCycle.m_nLightShadowStrength[i])
	Im.FarClip 					= new.int(CTimeCycle.m_fFarClip[i])
	Im.FogStart 				= new.int(CTimeCycle.m_fFogStart[i])
	Im.LightsOnGroundBrightness = new.int(CTimeCycle.m_fLightsOnGroundBrightness[i])
	Im.LowCloudsRGB 			= imgui.new.float[3](CTimeCycle.m_nLowCloudsRed[i] / 255, CTimeCycle.m_nLowCloudsGreen[i] / 255, CTimeCycle.m_nLowCloudsBlue[i] / 255)
	Im.FluffyCloudsBotttomRGB 	= imgui.new.float[3](CTimeCycle.m_nFluffyCloudsBottomRed[i] / 255, CTimeCycle.m_nFluffyCloudsBottomGreen[i] / 255, CTimeCycle.m_nFluffyCloudsBottomBlue[i] / 255)
	Im.WaterRGBA 				= imgui.new.float[4](CTimeCycle.m_fWaterRed[i] / 255, CTimeCycle.m_fWaterGreen[i] / 255, CTimeCycle.m_fWaterBlue[i] / 255, CTimeCycle.m_fWaterAlpha[i] / 255)
	Im.PostFx1RGBA 				= imgui.new.float[4](CTimeCycle.m_fPostFx1Red[i] / 255, CTimeCycle.m_fPostFx1Green[i] / 255, CTimeCycle.m_fPostFx1Blue[i] / 255, CTimeCycle.m_fPostFx1Alpha[i] / 255)
	Im.PostFx2RGBA 				= imgui.new.float[4](CTimeCycle.m_fPostFx2Red[i] / 255, CTimeCycle.m_fPostFx2Green[i] / 255, CTimeCycle.m_fPostFx2Blue[i] / 255, CTimeCycle.m_fPostFx2Alpha[i] / 255)
	Im.CloudAlpha 				= new.int(CTimeCycle.m_fCloudAlpha[i])
	Im.HighLightMinIntensity 	= new.int(CTimeCycle.m_nHighLightMinIntensity[i])
	Im.WaterFogAlpha 			= new.int(CTimeCycle.m_nWaterFogAlpha[i])
	Im.DirectionalMult 			= new.int(CTimeCycle.m_nDirectionalMult[i])
end

-- Timecyc Stuff
function CTimeCycle.GetCurrentHourTimeId()
	local h = Hours[0]
	local id = nil
	if bTimecyc24h then return h end

	if h < 5 then  id = 0 end
	if h == 5 then  id = 1 end
	if h == 6 then  id = 2 end
	if 7 <= h and h < 12 then  id = 3 end
	if 12 <= h and h < 19 then  id = 4 end
	if h == 19 then  id = 5 end
	if h == 20 or h == 21 then  id = 6 end
	if h == 22 or h == 23 then  id = 7 end
	return id
end


function CTimeCycle.SaveToFile(filename)
    if not doesDirectoryExist(getWorkingDirectory().."\\gamefixer\\timecyc") then
        createDirectory(getWorkingDirectory().."\\gamefixer\\timecyc")
    end
	local timecycdat = io.open(getWorkingDirectory().."\\gamefixer\\timecyc/"..filename .. ".dat", "w")
	local tc = CTimeCycle
	-- timecycdat:write("// TimeCycle created using Timecyc24h Editor\n// Be sure to check "..URL.." for updates!\n")

	for w = 0, NUMWEATHERS - 1 do
		timecycdat:write("//\n" .. "///////////////////////////////////////////" .. weather[w] .. " \n" .. "//\n")

		for h = 0, NUMHOURS - 1 do
			local i = NUMWEATHERS * h + w

			if bTimecyc24h then
				if (h >= 12) then
					if (h == 12) then
						timecycdat:write("// Midday \n")
					else
						timecycdat:write("// " .. (h - 12) .. "PM \n")
					end
				else
					if h == 0 then
						timecycdat:write("// Midnight \n")
					else
						timecycdat:write("// " .. h .. "AM \n")
					end
				end
			else
				if h == 0 then timecycdat:write("// Midnight\n") end
				if h == 1 then timecycdat:write("// 5 AM\n") end
				if h == 2 then timecycdat:write("// 6 AM\n") end
				if h == 3 then timecycdat:write("// 7 AM\n") end
				if h == 4 then timecycdat:write("// Midday\n") end
				if h == 5 then timecycdat:write("// 7 PM\n") end
				if h == 6 then timecycdat:write("// 8 PM\n") end
				if h == 7 then timecycdat:write("// 10 PM\n") end
			end


			-- timecycdat:write("// "..j.." \n")

			if (h == 0 or h == 12 and not bTimecyc24h) then
				timecycdat:write("//\tAmb\t\t\t\t\tAmb_Obj \t\t\t\tDir \t\t\t\t\tSky top\t\t\t\tSky bot\t\t\t\tSunCore\t\t\tSunCorona\t\t\tSunSz\t\tSprSz\tSprBght\t\tShdw\t\t\tLightShd\t\t\tPoleShd\t\t\tFarClp\t\t\tFogSt\t\t\tLightOnGround\t\t\tLowCloudsRGB\t\t\tBottomCloudRGB\t\t\tWaterRGBA\t\t\tAlpha1    RGB1\t\t\tAlpha2    RGB2\t\t\tCloudAlpha\t\t\tIntensityLimit\t\t\tWaterFogAlpha\t\t\tDirMult \n")
			end
			timecycdat:write(
				string.format(
					"\t%d %d %d \t\t" .. -- AmbRGB
					"\t%d %d %d \t\t" .. -- AmbObjRGB
					"\t%d %d %d \t\t" .. -- DirRGB (unused?)
					"\t%d %d %d \t\t" .. -- SkyTopRGB
					"\t%d %d %d \t\t" .. -- SkyBotRGB
					"\t%d %d %d \t\t" .. -- SunCore RGB
					"\t%d %d %d \t\t" .. -- SunCorona RGB
					"\t%.1f\t\t%.1f\t\t%.1f\t\t" .. -- SunSz, SpriteSz, SpriteBrightness
					"\t%d %d %d\t\t" .. -- ShadStrenght, LightShadStreght, PoleShadStrenght
					"\t%.1f\t\t%.1f\t\t%.1f\t\t" .. -- fFarClip, fFogStart, fLightsOnGroundBrightness
					"\t%d %d %d\t\t" .. -- LowCloudsRGB
					"\t%d %d %d\t\t" .. -- FluffyCloudsRGB
					"\t%d %d %d %d\t\t" .. -- WaterRGBA
					"\t%d %d %d %d\t\t" .. -- PostFx1ARGB
					"\t%d %d %d %d\t\t" .. -- PostFx2ARGB
					"\t%d\t%d\t%d\t%.2f\t\t\n", -- CloudAlpha HiLiMinIntensity WaterFogAlpha DirectionalMult
					tc.m_nAmbientRed[i], tc.m_nAmbientGreen[i],	tc.m_nAmbientBlue[i],
					tc.m_nAmbientRed_Obj[i], tc.m_nAmbientGreen_Obj[i],	tc.m_nAmbientBlue_Obj[i],
					255, 255, 255,
					tc.m_nSkyTopRed[i],	tc.m_nSkyTopGreen[i], tc.m_nSkyTopBlue[i],
					tc.m_nSkyBottomRed[i], tc.m_nSkyBottomGreen[i],	tc.m_nSkyBottomBlue[i],
					tc.m_nSunCoreRed[i],tc.m_nSunCoreGreen[i],tc.m_nSunCoreBlue[i],
					tc.m_nSunCoronaRed[i], tc.m_nSunCoronaGreen[i], tc.m_nSunCoronaBlue[i],
					(tc.m_fSunSize[i] - 0.5) / 10.0,(tc.m_fSpriteSize[i] - 0.5) / 10.0,(tc.m_fSpriteBrightness[i] - 0.5) / 10.0,
					tc.m_nShadowStrength[i],tc.m_nLightShadowStrength[i],tc.m_nPoleShadowStrength[i],
					tc.m_fFarClip[i],tc.m_fFogStart[i],	(tc.m_fLightsOnGroundBrightness[i] - 0.5) / 10.0,
					tc.m_nLowCloudsRed[i],tc.m_nLowCloudsGreen[i],tc.m_nLowCloudsBlue[i],
					tc.m_nFluffyCloudsBottomRed[i],tc.m_nFluffyCloudsBottomGreen[i],tc.m_nFluffyCloudsBottomBlue[i],
					tc.m_fWaterRed[i],tc.m_fWaterGreen[i],tc.m_fWaterBlue[i],tc.m_fWaterAlpha[i],
					tc.m_fPostFx1Alpha[i],tc.m_fPostFx1Red[i],tc.m_fPostFx1Green[i],tc.m_fPostFx1Blue[i],
					tc.m_fPostFx2Alpha[i],tc.m_fPostFx2Red[i],tc.m_fPostFx2Green[i],tc.m_fPostFx2Blue[i],
					tc.m_fCloudAlpha[i],tc.m_nHighLightMinIntensity[i],	tc.m_nWaterFogAlpha[i],	tc.m_nDirectionalMult[i] / 100.0
				)
			)
		end
	end
	io.close(timecycdat)
end



function SwitchTheStyle(theme)
    imgui.SwitchContext()

    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
    local ImVec2 = imgui.ImVec2

    --==[ STYLE ]==--
    imgui.GetStyle().WindowPadding = imgui.ImVec2(5, 5)
    imgui.GetStyle().FramePadding = imgui.ImVec2(5, 5)
    imgui.GetStyle().ItemSpacing = imgui.ImVec2(6, 6)
    imgui.GetStyle().ItemInnerSpacing = imgui.ImVec2(6, 6)
    imgui.GetStyle().TouchExtraPadding = imgui.ImVec2(5, 5)
    imgui.GetStyle().IndentSpacing = 5
    imgui.GetStyle().ScrollbarSize = 10
    imgui.GetStyle().GrabMinSize = 17

    style.AntiAliasedLines = true
    style.AntiAliasedFill = true
    --==[ BORDER ]==--
    imgui.GetStyle().WindowBorderSize = -1
    imgui.GetStyle().ChildBorderSize = 1
    imgui.GetStyle().PopupBorderSize = 1
    imgui.GetStyle().FrameBorderSize = 1
    imgui.GetStyle().TabBorderSize = 1

    --==[ ROUNDING ]==--
    imgui.GetStyle().WindowRounding = 0
    imgui.GetStyle().ChildRounding = 2
    imgui.GetStyle().FrameRounding = 2
    imgui.GetStyle().PopupRounding = 2
    imgui.GetStyle().ScrollbarRounding = 2
    imgui.GetStyle().GrabRounding = 2
    imgui.GetStyle().TabRounding = 2
    --==[ ALIGN ]==--
    imgui.GetStyle().WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().SelectableTextAlign = imgui.ImVec2(0.5, 0.5)
    
    if theme == 1 or theme == nil or theme == 0 then
        colors[clr.WindowBg]               = ImVec4(ini.WindowBG.r, ini.WindowBG.g, ini.WindowBG.b, ini.WindowBG.a)
        colors[clr.FrameBg]                = ImVec4(ini.FrameBg.r, ini.FrameBg.g, ini.FrameBg.b, ini.FrameBg.a)
        colors[clr.FrameBgHovered]         = ImVec4(ini.FrameBgHovered.r, ini.FrameBgHovered.g, ini.FrameBgHovered.b, ini.FrameBgHovered.a)
        colors[clr.FrameBgActive]          = ImVec4(ini.FrameBgActive.r, ini.FrameBgActive.g, ini.FrameBgActive.b, ini.FrameBgActive.a)
        colors[clr.CheckMark]              = ImVec4(ini.CheckMark.r, ini.CheckMark.g, ini.CheckMark.b, ini.CheckMark.a)
        colors[clr.SliderGrab]             = ImVec4(ini.SliderGrab.r, ini.SliderGrab.g, ini.SliderGrab.b, ini.SliderGrab.a)
        colors[clr.SliderGrabActive]       = ImVec4(ini.SliderGrabActive.r, ini.SliderGrabActive.g, ini.SliderGrabActive.b, ini.SliderGrabActive.a)
        colors[clr.Button]                 = ImVec4(ini.Button.r, ini.Button.g, ini.Button.b, ini.Button.a)
        colors[clr.ButtonHovered]          = ImVec4(ini.ButtonHovered.r, ini.ButtonHovered.g, ini.ButtonHovered.b, ini.ButtonHovered.a)
        colors[clr.ButtonActive]           = ImVec4(ini.ButtonActive.r, ini.ButtonActive.g, ini.ButtonActive.b, ini.ButtonActive.a)
        colors[clr.Header]                 = ImVec4(ini.Header.r, ini.Header.g, ini.Header.b, ini.Header.a)
        colors[clr.HeaderHovered]          = ImVec4(ini.HeaderHovered.r, ini.HeaderHovered.g, ini.HeaderHovered.b, ini.HeaderHovered.a)
        colors[clr.HeaderActive]           = ImVec4(ini.HeaderActive.r, ini.HeaderActive.g, ini.HeaderActive.b, ini.HeaderActive.a)
        colors[clr.Separator]              = colors[clr.Border]
        colors[clr.SeparatorHovered]       = ImVec4(0.26, 0.59, 0.98, 0.78)
        colors[clr.SeparatorActive]        = ImVec4(0.26, 0.59, 0.98, 1.00)
        colors[clr.ResizeGrip]             = ImVec4(0.26, 0.59, 0.98, 0.25)
        colors[clr.ResizeGripHovered]      = ImVec4(0.26, 0.59, 0.98, 0.67)
        colors[clr.ResizeGripActive]       = ImVec4(0.26, 0.59, 0.98, 0.95)
        colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.59, 0.98, 0.35)
        colors[clr.Text]                   = ImVec4(ini.ColorText.r, ini.ColorText.g, ini.ColorText.b, ini.ColorText.a)
        colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
        colors[clr.ChildBg]                = ImVec4(ini.ChildBG.r, ini.ChildBG.g, ini.ChildBG.b, ini.ChildBG.a)
        colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
        colors[clr.Border]                 = ImVec4(1.0, 1.0, 1.0, 0.10)
        colors[clr.BorderShadow]           = ImVec4(1.00, 1.00, 1.00, 0.07)
        colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
        colors[clr.ScrollbarBg]            = ImVec4(ini.ScrollbarBg.r, ini.ScrollbarBg.g, ini.ScrollbarBg.b, ini.ScrollbarBg.a)
        colors[clr.ScrollbarGrab]          = ImVec4(ini.ScrollbarGrab.r, ini.ScrollbarGrab.g, ini.ScrollbarGrab.b, ini.ScrollbarGrab.a)
        colors[clr.ScrollbarGrabHovered]   = ImVec4(ini.ScrollbarGrabHovered.r, ini.ScrollbarGrabHovered.g, ini.ScrollbarGrabHovered.b, ini.ScrollbarGrabHovered.a)
        colors[clr.ScrollbarGrabActive]    = ImVec4(ini.ScrollbarGrabActive.r, ini.ScrollbarGrabActive.g, ini.ScrollbarGrabActive.b, ini.ScrollbarGrabActive.a)
        colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
        colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
        colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
        colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
    elseif theme == 2 then
        colors[clr.FrameBg]                = ImVec4(0.48, 0.16, 0.16, 0.54)
        colors[clr.FrameBgHovered]         = ImVec4(0.98, 0.26, 0.26, 0.40)
        colors[clr.FrameBgActive]          = ImVec4(0.98, 0.26, 0.26, 0.67)
        colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
        colors[clr.TitleBgActive]          = ImVec4(0.48, 0.16, 0.16, 1.00)
        colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
        colors[clr.CheckMark]              = ImVec4(0.98, 0.26, 0.26, 1.00)
        colors[clr.SliderGrab]             = ImVec4(0.88, 0.26, 0.24, 1.00)
        colors[clr.SliderGrabActive]       = ImVec4(0.98, 0.26, 0.26, 1.00)
        colors[clr.Button]                 = ImVec4(0.98, 0.26, 0.26, 0.40)
        colors[clr.ButtonHovered]          = ImVec4(0.98, 0.26, 0.26, 1.00)
        colors[clr.ButtonActive]           = ImVec4(0.98, 0.06, 0.06, 1.00)
        colors[clr.Header]                 = ImVec4(0.98, 0.26, 0.26, 0.31)
        colors[clr.HeaderHovered]          = ImVec4(0.98, 0.26, 0.26, 0.80)
        colors[clr.HeaderActive]           = ImVec4(0.98, 0.26, 0.26, 1.00)
        colors[clr.Separator]              = colors[clr.Border]
        colors[clr.SeparatorHovered]       = ImVec4(0.75, 0.10, 0.10, 0.78)
        colors[clr.SeparatorActive]        = ImVec4(0.75, 0.10, 0.10, 1.00)
        colors[clr.ResizeGrip]             = ImVec4(0.98, 0.26, 0.26, 0.25)
        colors[clr.ResizeGripHovered]      = ImVec4(0.98, 0.26, 0.26, 0.67)
        colors[clr.ResizeGripActive]       = ImVec4(0.98, 0.26, 0.26, 0.95)
        colors[clr.TextSelectedBg]         = ImVec4(0.98, 0.26, 0.26, 0.35)
        colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
        colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
        colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
        colors[clr.ChildBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
        colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
        colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
        colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
        colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
        colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
        colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
        colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
        colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
        colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
        colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
        colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
        colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
    elseif theme == 3 then
        colors[clr.WindowBg]               = ImVec4(0.0, 0.0, 0.0, 1.00)
        colors[clr.FrameBg]                = ImVec4(0.48, 0.23, 0.16, 0.54)
        colors[clr.FrameBgHovered]         = ImVec4(0.98, 0.43, 0.26, 0.40)
        colors[clr.FrameBgActive]          = ImVec4(0.98, 0.43, 0.26, 0.67)
        colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
        colors[clr.TitleBgActive]          = ImVec4(0.48, 0.23, 0.16, 1.00)
        colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
        colors[clr.CheckMark]              = ImVec4(0.98, 0.43, 0.26, 1.00)
        colors[clr.SliderGrab]             = ImVec4(0.88, 0.39, 0.24, 1.00)
        colors[clr.SliderGrabActive]       = ImVec4(0.98, 0.43, 0.26, 1.00)
        colors[clr.Button]                 = ImVec4(0.98, 0.43, 0.26, 0.40)
        colors[clr.ButtonHovered]          = ImVec4(0.98, 0.43, 0.26, 1.00)
        colors[clr.ButtonActive]           = ImVec4(0.98, 0.28, 0.06, 1.00)
        colors[clr.Header]                 = ImVec4(0.98, 0.43, 0.26, 0.31)
        colors[clr.HeaderHovered]          = ImVec4(0.98, 0.43, 0.26, 0.80)
        colors[clr.HeaderActive]           = ImVec4(0.98, 0.43, 0.26, 1.00)
        colors[clr.Separator]              = colors[clr.Border]
        colors[clr.SeparatorHovered]       = ImVec4(0.75, 0.25, 0.10, 0.78)
        colors[clr.SeparatorActive]        = ImVec4(0.75, 0.25, 0.10, 1.00)
        colors[clr.ResizeGrip]             = ImVec4(0.98, 0.43, 0.26, 0.25)
        colors[clr.ResizeGripHovered]      = ImVec4(0.98, 0.43, 0.26, 0.67)
        colors[clr.ResizeGripActive]       = ImVec4(0.98, 0.43, 0.26, 0.95)
        colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
        colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.50, 0.35, 1.00)
        colors[clr.TextSelectedBg]         = ImVec4(0.98, 0.43, 0.26, 0.35)
        colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
        colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
        colors[clr.ChildBg]                = ImVec4(0.5, 0.2, 0.07, 0.10)
        colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
        colors[clr.Border]                 = ImVec4(1.0, 1.0, 1.0, 0.10)
        colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
        colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
        colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
        colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
        colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
        colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
        colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
        colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
    elseif theme == 4 then
        colors[clr.WindowBg]               = ImVec4(0.0, 0.0, 0.0, 1.00)
        colors[clr.FrameBg]                = ImVec4(0.16, 0.48, 0.42, 0.54)
        colors[clr.FrameBgHovered]         = ImVec4(0.26, 0.98, 0.85, 0.40)
        colors[clr.FrameBgActive]          = ImVec4(0.26, 0.98, 0.85, 0.67)
        colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
        colors[clr.TitleBgActive]          = ImVec4(0.16, 0.48, 0.42, 1.00)
        colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
        colors[clr.CheckMark]              = ImVec4(0.26, 0.98, 0.85, 1.00)
        colors[clr.SliderGrab]             = ImVec4(0.24, 0.88, 0.77, 1.00)
        colors[clr.SliderGrabActive]       = ImVec4(0.26, 0.98, 0.85, 1.00)
        colors[clr.Button]                 = ImVec4(0.26, 0.98, 0.85, 0.40)
        colors[clr.ButtonHovered]          = ImVec4(0.26, 0.98, 0.85, 1.00)
        colors[clr.ButtonActive]           = ImVec4(0.06, 0.98, 0.82, 1.00)
        colors[clr.Header]                 = ImVec4(0.26, 0.98, 0.85, 0.31)
        colors[clr.HeaderHovered]          = ImVec4(0.26, 0.98, 0.85, 0.80)
        colors[clr.HeaderActive]           = ImVec4(0.26, 0.98, 0.85, 1.00)
        colors[clr.Separator]              = colors[clr.Border]
        colors[clr.SeparatorHovered]       = ImVec4(0.10, 0.75, 0.63, 0.78)
        colors[clr.SeparatorActive]        = ImVec4(0.10, 0.75, 0.63, 1.00)
        colors[clr.ResizeGrip]             = ImVec4(0.26, 0.98, 0.85, 0.25)
        colors[clr.ResizeGripHovered]      = ImVec4(0.26, 0.98, 0.85, 0.67)
        colors[clr.ResizeGripActive]       = ImVec4(0.26, 0.98, 0.85, 0.95)
        colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
        colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.81, 0.35, 1.00)
        colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.98, 0.85, 0.35)
        colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
        colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
        colors[clr.ChildBg]                = ImVec4(0.06, 0.37, 0.35, 0.10)
        colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
        colors[clr.Border]                 = ImVec4(1.0, 1.0, 1.0, 0.10)
        colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
        colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
        colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
        colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
        colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
        colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
        colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
        colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
    elseif theme == 5 then
        colors[clr.WindowBg]               = ImVec4(0.0, 0.0, 0.0, 1.00)
        colors[clr.Text]                   = ImVec4(0.80, 0.80, 0.83, 1.00)
        colors[clr.TextDisabled]           = ImVec4(0.24, 0.23, 0.29, 1.00)
        colors[clr.ChildBg]                = ImVec4(0.07, 0.07, 0.09, 0.00)
        colors[clr.PopupBg]                = ImVec4(0.07, 0.07, 0.09, 1.00)
        colors[clr.Border]                 = ImVec4(1.0, 1.0, 1.0, 0.10)
        colors[clr.BorderShadow]           = ImVec4(0.92, 0.91, 0.88, 0.00)
        colors[clr.FrameBg]                = ImVec4(0.10, 0.09, 0.12, 0.54)
        colors[clr.FrameBgHovered]         = ImVec4(0.24, 0.23, 0.29, 1.00)
        colors[clr.FrameBgActive]          = ImVec4(0.56, 0.56, 0.58, 1.00)
        colors[clr.TitleBg]                = ImVec4(0.10, 0.09, 0.12, 1.00)
        colors[clr.TitleBgCollapsed]       = ImVec4(1.00, 0.98, 0.95, 0.75)
        colors[clr.TitleBgActive]          = ImVec4(0.07, 0.07, 0.09, 1.00)
        colors[clr.MenuBarBg]              = ImVec4(0.10, 0.09, 0.12, 1.00)
        colors[clr.ScrollbarBg]            = ImVec4(0.10, 0.09, 0.12, 1.00)
        colors[clr.ScrollbarGrab]          = ImVec4(0.80, 0.80, 0.83, 0.31)
        colors[clr.ScrollbarGrabHovered]   = ImVec4(0.56, 0.56, 0.58, 1.00)
        colors[clr.ScrollbarGrabActive]    = ImVec4(0.06, 0.05, 0.07, 1.00)
        colors[clr.CheckMark]              = ImVec4(0.80, 0.80, 0.83, 0.31)
        colors[clr.SliderGrab]             = ImVec4(0.80, 0.80, 0.83, 0.31)
        colors[clr.SliderGrabActive]       = ImVec4(0.06, 0.05, 0.07, 1.00)
        colors[clr.Button]                 = ImVec4(0.10, 0.09, 0.12, 1.00)
        colors[clr.ButtonHovered]          = ImVec4(0.24, 0.23, 0.29, 1.00)
        colors[clr.ButtonActive]           = ImVec4(0.56, 0.56, 0.58, 1.00)
        colors[clr.Header]                 = ImVec4(0.10, 0.09, 0.12, 1.00)
        colors[clr.HeaderHovered]          = ImVec4(0.56, 0.56, 0.58, 1.00)
        colors[clr.HeaderActive]           = ImVec4(0.06, 0.05, 0.07, 1.00)
        colors[clr.ResizeGrip]             = ImVec4(0.00, 0.00, 0.00, 0.00)
        colors[clr.ResizeGripHovered]      = ImVec4(0.56, 0.56, 0.58, 1.00)
        colors[clr.ResizeGripActive]       = ImVec4(0.06, 0.05, 0.07, 1.00)
        colors[clr.PlotLines]              = ImVec4(0.40, 0.39, 0.38, 0.63)
        colors[clr.PlotLinesHovered]       = ImVec4(0.25, 1.00, 0.00, 1.00)
        colors[clr.PlotHistogram]          = ImVec4(0.40, 0.39, 0.38, 0.63)
        colors[clr.PlotHistogramHovered]   = ImVec4(0.25, 1.00, 0.00, 1.00)
        colors[clr.TextSelectedBg]         = ImVec4(0.25, 1.00, 0.00, 0.43)
    elseif theme == 6 then
        colors[clr.WindowBg]               = ImVec4(0.0, 0.0, 0.0, 1.00)
        colors[clr.Text]                 = ImVec4(1.00, 1.00, 1.00, 1.00)
        colors[clr.TextDisabled]         = ImVec4(0.60, 0.60, 0.60, 1.00)
        colors[clr.ChildBg]              = ImVec4(0.23, 0, 0.46, 0.10)
        colors[clr.PopupBg]              = ImVec4(0.09, 0.09, 0.09, 1.00)
        colors[clr.Border]                 = ImVec4(1.0, 1.0, 1.0, 0.10)
        colors[clr.BorderShadow]         = ImVec4(9.90, 9.99, 9.99, 0.00)
        colors[clr.FrameBg]              = ImVec4(0.34, 0.30, 0.34, 0.54)
        colors[clr.FrameBgHovered]       = ImVec4(0.22, 0.21, 0.21, 0.40)
        colors[clr.FrameBgActive]        = ImVec4(0.20, 0.20, 0.20, 0.44)
        colors[clr.TitleBg]              = ImVec4(0.52, 0.27, 0.77, 1.00)
        colors[clr.TitleBgActive]        = ImVec4(0.55, 0.28, 0.75, 1.00)
        colors[clr.TitleBgCollapsed]     = ImVec4(9.99, 9.99, 9.90, 0.20)
        colors[clr.MenuBarBg]            = ImVec4(0.27, 0.27, 0.29, 0.80)
        colors[clr.ScrollbarBg]          = ImVec4(0.30, 0.20, 0.39, 1.00)
        colors[clr.ScrollbarGrab]        = ImVec4(0.41, 0.19, 0.63, 0.31)
        colors[clr.ScrollbarGrabHovered] = ImVec4(0.41, 0.19, 0.63, 0.78)
        colors[clr.ScrollbarGrabActive]  = ImVec4(0.41, 0.19, 0.63, 1.00)
        colors[clr.CheckMark]            = ImVec4(0.89, 0.89, 0.89, 0.50)
        colors[clr.SliderGrab]           = ImVec4(1.00, 1.00, 1.00, 0.30)
        colors[clr.SliderGrabActive]     = ImVec4(0.80, 0.50, 0.50, 1.00)
        colors[clr.Button]               = ImVec4(0.41, 0.19, 0.63, 0.44)
        colors[clr.ButtonHovered]        = ImVec4(0.41, 0.19, 0.63, 1.00)
        colors[clr.ButtonActive]         = ImVec4(0.64, 0.33, 0.94, 1.00)
        colors[clr.Header]               = ImVec4(0.56, 0.27, 0.73, 0.44)
        colors[clr.HeaderHovered]        = ImVec4(0.78, 0.44, 0.89, 0.80)
        colors[clr.HeaderActive]         = ImVec4(0.81, 0.52, 0.87, 0.80)
        colors[clr.Separator]            = ImVec4(0.42, 0.42, 0.42, 1.00)
        colors[clr.SeparatorHovered]     = ImVec4(0.57, 0.24, 0.73, 1.00)
        colors[clr.SeparatorActive]      = ImVec4(0.69, 0.69, 0.89, 1.00)
        colors[clr.ResizeGrip]           = ImVec4(1.00, 1.00, 1.00, 0.30)
        colors[clr.ResizeGripHovered]    = ImVec4(1.00, 1.00, 1.00, 0.60)
        colors[clr.ResizeGripActive]     = ImVec4(1.00, 1.00, 1.00, 0.89)
        colors[clr.PlotLines]            = ImVec4(1.00, 0.99, 0.99, 1.00)
        colors[clr.PlotLinesHovered]     = ImVec4(0.49, 0.00, 0.89, 1.00)
        colors[clr.PlotHistogram]        = ImVec4(9.99, 9.99, 9.90, 1.00)
        colors[clr.PlotHistogramHovered] = ImVec4(9.99, 9.99, 9.90, 1.00)
        colors[clr.TextSelectedBg]       = ImVec4(0.54, 0.00, 1.00, 0.34)
    elseif theme == 7 then
        colors[clr.WindowBg]               = ImVec4(0.0, 0.0, 0.0, 1.00)
        colors[clr.Text]                   = ImVec4(0.80, 0.80, 0.83, 1.00)
        colors[clr.TextDisabled]           = ImVec4(0.24, 0.23, 0.29, 1.00)
        colors[clr.ChildBg]                = ImVec4(0.07, 0.07, 0.09, 0.00)
        colors[clr.PopupBg]                = ImVec4(0.07, 0.07, 0.09, 1.00)
        colors[clr.Border]                 = ImVec4(1.0, 1.0, 1.0, 0.10)
        colors[clr.BorderShadow]           = ImVec4(0.92, 0.91, 0.88, 0.00)
        colors[clr.FrameBg]                = ImVec4(0.10, 0.09, 0.12, 0.54)
        colors[clr.FrameBgHovered]         = ImVec4(0.24, 0.23, 0.29, 1.00)
        colors[clr.FrameBgActive]          = ImVec4(0.56, 0.56, 0.58, 1.00)
        colors[clr.TitleBg]                = ImVec4(0.76, 0.31, 0.00, 1.00)
        colors[clr.TitleBgCollapsed]       = ImVec4(1.00, 0.98, 0.95, 0.75)
        colors[clr.TitleBgActive]          = ImVec4(0.80, 0.33, 0.00, 1.00)
        colors[clr.MenuBarBg]              = ImVec4(0.10, 0.09, 0.12, 1.00)
        colors[clr.ScrollbarBg]            = ImVec4(0.10, 0.09, 0.12, 1.00)
        colors[clr.ScrollbarGrab]          = ImVec4(0.80, 0.80, 0.83, 0.31)
        colors[clr.ScrollbarGrabHovered]   = ImVec4(0.56, 0.56, 0.58, 1.00)
        colors[clr.ScrollbarGrabActive]    = ImVec4(0.06, 0.05, 0.07, 1.00)
        colors[clr.CheckMark]              = ImVec4(1.00, 0.42, 0.00, 0.53)
        colors[clr.SliderGrab]             = ImVec4(1.00, 0.42, 0.00, 0.53)
        colors[clr.SliderGrabActive]       = ImVec4(1.00, 0.42, 0.00, 1.00)
        colors[clr.Button]                 = ImVec4(0.10, 0.09, 0.12, 1.00)
        colors[clr.ButtonHovered]          = ImVec4(0.24, 0.23, 0.29, 1.00)
        colors[clr.ButtonActive]           = ImVec4(0.56, 0.56, 0.58, 1.00)
        colors[clr.Header]                 = ImVec4(0.10, 0.09, 0.12, 1.00)
        colors[clr.HeaderHovered]          = ImVec4(0.56, 0.56, 0.58, 1.00)
        colors[clr.HeaderActive]           = ImVec4(0.06, 0.05, 0.07, 1.00)
        colors[clr.ResizeGrip]             = ImVec4(0.00, 0.00, 0.00, 0.00)
        colors[clr.ResizeGripHovered]      = ImVec4(0.56, 0.56, 0.58, 1.00)
        colors[clr.ResizeGripActive]       = ImVec4(0.06, 0.05, 0.07, 1.00)
        colors[clr.PlotLines]              = ImVec4(0.40, 0.39, 0.38, 0.63)
        colors[clr.PlotLinesHovered]       = ImVec4(0.25, 1.00, 0.00, 1.00)
        colors[clr.PlotHistogram]          = ImVec4(0.40, 0.39, 0.38, 0.63)
        colors[clr.PlotHistogramHovered]   = ImVec4(0.25, 1.00, 0.00, 1.00)
        colors[clr.TextSelectedBg]         = ImVec4(0.25, 1.00, 0.00, 0.43)
    elseif theme == 8 then
        colors[clr.WindowBg]               = ImVec4(0.0, 0.0, 0.0, 1.00)
        colors[clr.Text]                   = ImVec4(0.95, 0.96, 0.98, 1.00)
        colors[clr.TextDisabled]           = ImVec4(0.36, 0.42, 0.47, 1.00)
        colors[clr.ChildBg]                = ImVec4(0.15, 0.18, 0.22, 0.30)
        colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
        colors[clr.Border]                 = ImVec4(1.0, 1.0, 1.0, 0.10)
        colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
        colors[clr.FrameBg]                = ImVec4(0.20, 0.25, 0.29, 0.54)
        colors[clr.FrameBgHovered]         = ImVec4(0.12, 0.20, 0.28, 1.00)
        colors[clr.FrameBgActive]          = ImVec4(0.09, 0.12, 0.14, 1.00)
        colors[clr.TitleBg]                = ImVec4(0.09, 0.12, 0.14, 1.00)
        colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
        colors[clr.TitleBgActive]          = ImVec4(0.08, 0.10, 0.12, 1.00)
        colors[clr.MenuBarBg]              = ImVec4(0.15, 0.18, 0.22, 1.00)
        colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.39)
        colors[clr.ScrollbarGrab]          = ImVec4(0.20, 0.25, 0.29, 1.00)
        colors[clr.ScrollbarGrabHovered]   = ImVec4(0.18, 0.22, 0.25, 1.00)
        colors[clr.ScrollbarGrabActive]    = ImVec4(0.09, 0.21, 0.31, 1.00)
        colors[clr.CheckMark]              = ImVec4(0.28, 0.56, 1.00, 1.00)
        colors[clr.SliderGrab]             = ImVec4(0.28, 0.56, 1.00, 1.00)
        colors[clr.SliderGrabActive]       = ImVec4(0.37, 0.61, 1.00, 1.00)
        colors[clr.Button]                 = ImVec4(0.20, 0.25, 0.29, 1.00)
        colors[clr.ButtonHovered]          = ImVec4(0.28, 0.56, 1.00, 1.00)
        colors[clr.ButtonActive]           = ImVec4(0.06, 0.53, 0.98, 1.00)
        colors[clr.Header]                 = ImVec4(0.20, 0.25, 0.29, 0.55)
        colors[clr.HeaderHovered]          = ImVec4(0.26, 0.59, 0.98, 0.80)
        colors[clr.HeaderActive]           = ImVec4(0.26, 0.59, 0.98, 1.00)
        colors[clr.ResizeGrip]             = ImVec4(0.26, 0.59, 0.98, 0.25)
        colors[clr.ResizeGripHovered]      = ImVec4(0.26, 0.59, 0.98, 0.67)
        colors[clr.ResizeGripActive]       = ImVec4(0.06, 0.05, 0.07, 1.00)
        colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
        colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
        colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
        colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
        colors[clr.TextSelectedBg]         = ImVec4(0.25, 1.00, 0.00, 0.43)
    elseif theme == 9 then
        colors[clr.WindowBg]               = ImVec4(0.0, 0.0, 0.0, 1.00)
        colors[clr.Text]                   = ImVec4(0.860, 0.930, 0.890, 0.78)
        colors[clr.TextDisabled]           = ImVec4(0.860, 0.930, 0.890, 0.28)
        colors[clr.ChildBg]                = ImVec4(0.36, 0.06, 0.19, 0.10)
        colors[clr.PopupBg]                = ImVec4(0.200, 0.220, 0.270, 0.9)
        colors[clr.Border]                 = ImVec4(1.0, 1.0, 1.0, 0.10)
        colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
        colors[clr.FrameBg]                = ImVec4(0.200, 0.220, 0.270, 0.54)
        colors[clr.FrameBgHovered]         = ImVec4(0.455, 0.198, 0.301, 0.78)
        colors[clr.FrameBgActive]          = ImVec4(0.455, 0.198, 0.301, 1.00)
        colors[clr.TitleBg]                = ImVec4(0.232, 0.201, 0.271, 1.00)
        colors[clr.TitleBgActive]          = ImVec4(0.502, 0.075, 0.256, 1.00)
        colors[clr.TitleBgCollapsed]       = ImVec4(0.200, 0.220, 0.270, 0.75)
        colors[clr.MenuBarBg]              = ImVec4(0.200, 0.220, 0.270, 0.47)
        colors[clr.ScrollbarBg]            = ImVec4(0.200, 0.220, 0.270, 1.00)
        colors[clr.ScrollbarGrab]          = ImVec4(0.09, 0.15, 0.1, 1.00)
        colors[clr.ScrollbarGrabHovered]   = ImVec4(0.455, 0.198, 0.301, 0.78)
        colors[clr.ScrollbarGrabActive]    = ImVec4(0.455, 0.198, 0.301, 1.00)
        colors[clr.CheckMark]              = ImVec4(0.71, 0.22, 0.27, 1.00)
        colors[clr.SliderGrab]             = ImVec4(0.47, 0.77, 0.83, 0.14)
        colors[clr.SliderGrabActive]       = ImVec4(0.71, 0.22, 0.27, 1.00)
        colors[clr.Button]                 = ImVec4(0.457, 0.200, 0.303, 1.00)
        colors[clr.ButtonHovered]          = ImVec4(0.455, 0.198, 0.301, 1.00)
        colors[clr.ButtonActive]           = ImVec4(0.455, 0.198, 0.301, 1.00)
        colors[clr.Header]                 = ImVec4(0.455, 0.198, 0.301, 0.76)
        colors[clr.HeaderHovered]          = ImVec4(0.455, 0.198, 0.301, 0.86)
        colors[clr.HeaderActive]           = ImVec4(0.502, 0.075, 0.256, 1.00)
        colors[clr.ResizeGrip]             = ImVec4(0.47, 0.77, 0.83, 0.04)
        colors[clr.ResizeGripHovered]      = ImVec4(0.455, 0.198, 0.301, 0.78)
        colors[clr.ResizeGripActive]       = ImVec4(0.455, 0.198, 0.301, 1.00)
        colors[clr.PlotLines]              = ImVec4(0.860, 0.930, 0.890, 0.63)
        colors[clr.PlotLinesHovered]       = ImVec4(0.455, 0.198, 0.301, 1.00)
        colors[clr.PlotHistogram]          = ImVec4(0.860, 0.930, 0.890, 0.63)
        colors[clr.PlotHistogramHovered]   = ImVec4(0.455, 0.198, 0.301, 1.00)
        colors[clr.TextSelectedBg]         = ImVec4(0.455, 0.198, 0.301, 0.43)
    elseif theme == 10 then
        colors[clr.WindowBg]               = ImVec4(0.0, 0.0, 0.0, 1.00)
        colors[clr.Text]                   = ImVec4(0.90, 0.90, 0.90, 1.00)
        colors[clr.TextDisabled]           = ImVec4(0.60, 0.60, 0.60, 1.00)
        colors[clr.ChildBg]                = ImVec4(0, 0.46, 0.08, 0.10)
        colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 1.00)
        colors[clr.Border]                 = ImVec4(1.0, 1.0, 1.0, 0.10)
        colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
        colors[clr.FrameBg]                = ImVec4(0.15, 0.15, 0.15, 0.54)
        colors[clr.FrameBgHovered]         = ImVec4(0.19, 0.19, 0.19, 0.71)
        colors[clr.FrameBgActive]          = ImVec4(0.34, 0.34, 0.34, 0.79)
        colors[clr.TitleBg]                = ImVec4(0.00, 0.69, 0.33, 1.00)
        colors[clr.TitleBgActive]          = ImVec4(0.00, 0.74, 0.36, 1.00)
        colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.69, 0.33, 0.50)
        colors[clr.MenuBarBg]              = ImVec4(0.00, 0.80, 0.38, 1.00)
        colors[clr.ScrollbarBg]            = ImVec4(0.16, 0.16, 0.16, 1.00)
        colors[clr.ScrollbarGrab]          = ImVec4(0.00, 0.69, 0.33, 1.00)
        colors[clr.ScrollbarGrabHovered]   = ImVec4(0.00, 0.82, 0.39, 1.00)
        colors[clr.ScrollbarGrabActive]    = ImVec4(0.00, 1.00, 0.48, 1.00)
        colors[clr.CheckMark]              = ImVec4(0.00, 0.69, 0.33, 1.00)
        colors[clr.SliderGrab]             = ImVec4(0.00, 0.69, 0.33, 1.00)
        colors[clr.SliderGrabActive]       = ImVec4(0.00, 0.77, 0.37, 1.00)
        colors[clr.Button]                 = ImVec4(0.00, 0.69, 0.33, 1.00)
        colors[clr.ButtonHovered]          = ImVec4(0.00, 0.82, 0.39, 1.00)
        colors[clr.ButtonActive]           = ImVec4(0.00, 0.87, 0.42, 1.00)
        colors[clr.Header]                 = ImVec4(0.00, 0.69, 0.33, 1.00)
        colors[clr.HeaderHovered]          = ImVec4(0.00, 0.76, 0.37, 0.57)
        colors[clr.HeaderActive]           = ImVec4(0.00, 0.88, 0.42, 0.89)
        colors[clr.Separator]              = ImVec4(1.00, 1.00, 1.00, 0.40)
        colors[clr.SeparatorHovered]       = ImVec4(1.00, 1.00, 1.00, 0.60)
        colors[clr.SeparatorActive]        = ImVec4(1.00, 1.00, 1.00, 0.80)
        colors[clr.ResizeGrip]             = ImVec4(0.00, 0.69, 0.33, 1.00)
        colors[clr.ResizeGripHovered]      = ImVec4(0.00, 0.76, 0.37, 1.00)
        colors[clr.ResizeGripActive]       = ImVec4(0.00, 0.86, 0.41, 1.00)
        colors[clr.PlotLines]              = ImVec4(0.00, 0.69, 0.33, 1.00)
        colors[clr.PlotLinesHovered]       = ImVec4(0.00, 0.74, 0.36, 1.00)
        colors[clr.PlotHistogram]          = ImVec4(0.00, 0.69, 0.33, 1.00)
        colors[clr.PlotHistogramHovered]   = ImVec4(0.00, 0.80, 0.38, 1.00)
        colors[clr.TextSelectedBg]         = ImVec4(0.00, 0.69, 0.33, 0.72)
    elseif theme == 11 then
        colors[clr.WindowBg]               = ImVec4(0.0, 0.0, 0.0, 1.00)
        colors[clr.FrameBg]                = ImVec4(0.46, 0.11, 0.29, 0.54)
        colors[clr.FrameBgHovered]         = ImVec4(0.69, 0.16, 0.43, 1.00)
        colors[clr.FrameBgActive]          = ImVec4(0.58, 0.10, 0.35, 1.00)
        colors[clr.TitleBg]                = ImVec4(0.00, 0.00, 0.00, 1.00)
        colors[clr.TitleBgActive]          = ImVec4(0.61, 0.16, 0.39, 1.00)
        colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
        colors[clr.CheckMark]              = ImVec4(0.94, 0.30, 0.63, 1.00)
        colors[clr.SliderGrab]             = ImVec4(0.85, 0.11, 0.49, 1.00)
        colors[clr.SliderGrabActive]       = ImVec4(0.89, 0.24, 0.58, 1.00)
        colors[clr.Button]                 = ImVec4(0.46, 0.11, 0.29, 1.00)
        colors[clr.ButtonHovered]          = ImVec4(0.69, 0.17, 0.43, 1.00)
        colors[clr.ButtonActive]           = ImVec4(0.59, 0.10, 0.35, 1.00)
        colors[clr.Header]                 = ImVec4(0.46, 0.11, 0.29, 1.00)
        colors[clr.HeaderHovered]          = ImVec4(0.69, 0.16, 0.43, 1.00)
        colors[clr.HeaderActive]           = ImVec4(0.58, 0.10, 0.35, 1.00)
        colors[clr.Separator]              = ImVec4(0.69, 0.16, 0.43, 1.00)
        colors[clr.SeparatorHovered]       = ImVec4(0.58, 0.10, 0.35, 1.00)
        colors[clr.SeparatorActive]        = ImVec4(0.58, 0.10, 0.35, 1.00)
        colors[clr.ResizeGrip]             = ImVec4(0.46, 0.11, 0.29, 0.70)
        colors[clr.ResizeGripHovered]      = ImVec4(0.69, 0.16, 0.43, 0.67)
        colors[clr.ResizeGripActive]       = ImVec4(0.70, 0.13, 0.42, 1.00)
        colors[clr.TextSelectedBg]         = ImVec4(1.00, 0.78, 0.90, 0.35)
        colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
        colors[clr.TextDisabled]           = ImVec4(0.60, 0.19, 0.40, 1.00)
        colors[clr.ChildBg]                = ImVec4(0.68, 0, 0.41, 0.10)
        colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
        colors[clr.Border]                 = ImVec4(1.0, 1.0, 1.0, 0.10)
        colors[clr.BorderShadow]           = ImVec4(0.49, 0.14, 0.31, 0.00)
        colors[clr.MenuBarBg]              = ImVec4(0.15, 0.15, 0.15, 1.00)
        colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
        colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
        colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
        colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
    elseif theme == 12 then
        colors[clr.WindowBg]               = ImVec4(0.0, 0.0, 0.0, 1.00)
        colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
        colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
        colors[clr.ChildBg]                = ImVec4(0, 0.27, 0.11, 0.10)
        colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
        colors[clr.Border]                 = ImVec4(1.0, 1.0, 1.0, 0.10)
        colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
        colors[clr.FrameBg]                = ImVec4(0.44, 0.44, 0.44, 0.54)
        colors[clr.FrameBgHovered]         = ImVec4(0.57, 0.57, 0.57, 0.70)
        colors[clr.FrameBgActive]          = ImVec4(0.76, 0.76, 0.76, 0.80)
        colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
        colors[clr.TitleBgActive]          = ImVec4(0.16, 0.16, 0.16, 1.00)
        colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.60)
        colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
        colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
        colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
        colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
        colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
        colors[clr.CheckMark]              = ImVec4(0.13, 0.75, 0.55, 0.80)
        colors[clr.SliderGrab]             = ImVec4(0.13, 0.75, 0.75, 0.80)
        colors[clr.SliderGrabActive]       = ImVec4(0.13, 0.75, 1.00, 0.80)
        colors[clr.Button]                 = ImVec4(0.13, 0.75, 0.55, 0.40)
        colors[clr.ButtonHovered]          = ImVec4(0.13, 0.75, 0.75, 0.60)
        colors[clr.ButtonActive]           = ImVec4(0.13, 0.75, 1.00, 0.80)
        colors[clr.Header]                 = ImVec4(0.13, 0.75, 0.55, 0.40)
        colors[clr.HeaderHovered]          = ImVec4(0.13, 0.75, 0.75, 0.60)
        colors[clr.HeaderActive]           = ImVec4(0.13, 0.75, 1.00, 0.80)
        colors[clr.Separator]              = ImVec4(0.13, 0.75, 0.55, 0.40)
        colors[clr.SeparatorHovered]       = ImVec4(0.13, 0.75, 0.75, 0.60)
        colors[clr.SeparatorActive]        = ImVec4(0.13, 0.75, 1.00, 0.80)
        colors[clr.ResizeGrip]             = ImVec4(0.13, 0.75, 0.55, 0.40)
        colors[clr.ResizeGripHovered]      = ImVec4(0.13, 0.75, 0.75, 0.60)
        colors[clr.ResizeGripActive]       = ImVec4(0.13, 0.75, 1.00, 0.80)
        colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
        colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
        colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
        colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
        colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.59, 0.98, 0.35)
    elseif theme == 13 then
        colors[clr.WindowBg]               = ImVec4(0.0, 0.0, 0.0, 1.00)
        colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.96)
        colors[clr.Border]                 = ImVec4(1.0, 1.0, 1.0, 0.10)
        colors[clr.FrameBg]                = ImVec4(0.49, 0.24, 0.00, 0.54)
        colors[clr.ChildBg]                = ImVec4(0.8, 0.24, 0, 0.10)
        colors[clr.FrameBgHovered]         = ImVec4(0.65, 0.32, 0.00, 1.00)
        colors[clr.FrameBgActive]          = ImVec4(0.73, 0.36, 0.00, 1.00)
        colors[clr.TitleBg]                = ImVec4(0.15, 0.11, 0.09, 1.00)
        colors[clr.TitleBgActive]          = ImVec4(0.73, 0.36, 0.00, 1.00)
        colors[clr.TitleBgCollapsed]       = ImVec4(0.15, 0.11, 0.09, 0.51)
        colors[clr.MenuBarBg]              = ImVec4(0.62, 0.31, 0.00, 1.00)
        colors[clr.CheckMark]              = ImVec4(1.00, 0.49, 0.00, 1.00)
        colors[clr.SliderGrab]             = ImVec4(0.84, 0.41, 0.00, 1.00)
        colors[clr.SliderGrabActive]       = ImVec4(0.98, 0.49, 0.00, 1.00)
        colors[clr.Button]                 = ImVec4(0.73, 0.36, 0.00, 0.40)
        colors[clr.ButtonHovered]          = ImVec4(0.73, 0.36, 0.00, 1.00)
        colors[clr.ButtonActive]           = ImVec4(1.00, 0.50, 0.00, 1.00)
        colors[clr.Header]                 = ImVec4(0.49, 0.24, 0.00, 1.00)
        colors[clr.HeaderHovered]          = ImVec4(0.70, 0.35, 0.01, 1.00)
        colors[clr.HeaderActive]           = ImVec4(1.00, 0.49, 0.00, 1.00)
        colors[clr.SeparatorHovered]       = ImVec4(0.49, 0.24, 0.00, 0.78)
        colors[clr.SeparatorActive]        = ImVec4(0.49, 0.24, 0.00, 1.00)
        colors[clr.ResizeGrip]             = ImVec4(0.48, 0.23, 0.00, 1.00)
        colors[clr.ResizeGripHovered]      = ImVec4(0.78, 0.38, 0.00, 1.00)
        colors[clr.ResizeGripActive]       = ImVec4(1.00, 0.49, 0.00, 1.00)
        colors[clr.PlotLines]              = ImVec4(0.83, 0.41, 0.00, 1.00)
        colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.99, 0.00, 1.00)
        colors[clr.PlotHistogram]          = ImVec4(0.93, 0.46, 0.00, 1.00)
        colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.59, 0.98, 0.00)
        colors[clr.ScrollbarBg]            = ImVec4(0.00, 0.00, 0.00, 0.53)
        colors[clr.ScrollbarGrab]          = ImVec4(0.33, 0.33, 0.33, 1.00)
        colors[clr.ScrollbarGrabHovered]   = ImVec4(0.39, 0.39, 0.39, 1.00)
        colors[clr.ScrollbarGrabActive]    = ImVec4(0.48, 0.48, 0.48, 1.00)
    elseif theme == 14 then
        colors[clr.FrameBg]                = ImVec4(0.16, 0.29, 0.48, 0.54)
        colors[clr.FrameBgHovered]         = ImVec4(0.26, 0.59, 0.98, 0.40)
        colors[clr.FrameBgActive]          = ImVec4(0.26, 0.59, 0.98, 0.67)
        colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
        colors[clr.TitleBgActive]          = ImVec4(0.16, 0.29, 0.48, 1.00)
        colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
        colors[clr.CheckMark]              = ImVec4(0.26, 0.59, 0.98, 1.00)
        colors[clr.SliderGrab]             = ImVec4(0.24, 0.52, 0.88, 1.00)
        colors[clr.SliderGrabActive]       = ImVec4(0.26, 0.59, 0.98, 1.00)
        colors[clr.Button]                 = ImVec4(0.26, 0.59, 0.98, 0.40)
        colors[clr.ButtonHovered]          = ImVec4(0.26, 0.59, 0.98, 1.00)
        colors[clr.ButtonActive]           = ImVec4(0.06, 0.53, 0.98, 1.00)
        colors[clr.Header]                 = ImVec4(0.26, 0.59, 0.98, 0.31)
        colors[clr.HeaderHovered]          = ImVec4(0.26, 0.59, 0.98, 0.80)
        colors[clr.HeaderActive]           = ImVec4(0.26, 0.59, 0.98, 1.00)
        colors[clr.Separator]              = colors[clr.Border]
        colors[clr.SeparatorHovered]       = ImVec4(0.26, 0.59, 0.98, 0.78)
        colors[clr.SeparatorActive]        = ImVec4(0.26, 0.59, 0.98, 1.00)
        colors[clr.ResizeGrip]             = ImVec4(0.26, 0.59, 0.98, 0.25)
        colors[clr.ResizeGripHovered]      = ImVec4(0.26, 0.59, 0.98, 0.67)
        colors[clr.ResizeGripActive]       = ImVec4(0.26, 0.59, 0.98, 0.95)
        colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.59, 0.98, 0.35)
        colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
        colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
        colors[clr.WindowBg]               = ImVec4(0.0, 0.0, 0.0, 1.00)
        colors[clr.ChildBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
        colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
        colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.20)
        colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
        colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
        colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
        colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
        colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
        colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
        colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
        colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
        colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
        colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
    end
end

function resethook()
    --====================================== [ reset hook ] ==============================================
    local function hkReset(pDevice, pPresentationParameters)
        if ini.settings.refreshratefix then
            pPresentationParameters.FullScreen_RefreshRateInHz = pPresentationParameters.Windowed == true and 300 or 0
        end
        if isSampAvailable() then
            --gotofunc("NoSounds")
            gotofunc("UgenrlMode")
            
        end
        return hkReset(pDevice, pPresentationParameters)
    end

    local D3D9Device_HookReset = hooks.vmt.new(ffi.cast('uintptr_t*', 0xC97C28)[0])
    hkReset = D3D9Device_HookReset.hookMethod('long(__stdcall*)(void*, D3DPRESENT_PARAMETERS*)', hkReset, 16)
    --====================================================================================================
end

local frequency_large = ffi.new("LARGE_INTEGER")
kernel32.QueryPerformanceFrequency(frequency_large)
perfomance_frequency = tonumber(frequency_large.QuadPart)

get_current_tick = function()
    local ticks_large = ffi.new("LARGE_INTEGER")
    kernel32.QueryPerformanceCounter(ticks_large)
    return tonumber(ticks_large.QuadPart)
end

get_current_ms = function()
    return get_current_tick() * (1000 / perfomance_frequency)
end
  
hard_wait = function(ms)
    local target = get_current_ms() + ms

    while get_current_ms() < target do end
end

function presenthook()
    --====================================== [ present hook ] ==============================================
    local _last_frame_time = 0
    local function hkPresent(pDevice, pSourceRect, pDestRect, hDestWindowOverride, pDirtyRegion)
            if TARGET_FRAMERATE >= 4 and  TARGET_FRAMERATE <= 299 then

                if _last_frame_time ~= 0 then
                    local time_lost_to_swap = winmm.timeGetTime() - _last_frame_time
                    local time_to_swap = 1000 / TARGET_FRAMERATE
                    if time_lost_to_swap < time_to_swap then
                        hard_wait(time_to_swap - time_lost_to_swap)
                    end
                end

                _last_frame_time = winmm.timeGetTime()
            end
        return hkPresent(pDevice, pSourceRect, pDestRect, hDestWindowOverride, pDirtyRegion)
    end

    local D3D9Device_HookPresent = hooks.vmt.new(ffi.cast('intptr_t*', 0xC97C28)[0])
    hkPresent = D3D9Device_HookPresent.hookMethod('long(__stdcall*)(void*, void*, void*, void*, void*)', hkPresent, 17)
    --====================================================================================================
end
