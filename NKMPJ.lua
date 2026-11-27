-- NKMPJ HUB V8.1.17.4 | SMART FARM BENCHMARK | ONE FILE
-- Exact V7.9.4 farm function restored without internal modifications.
-- V8 Premium Compact UI and Live Size operate from independent UI event listeners.
-- If the farm stops again, the Quick HUD displays the game's actual stop reason.
-- Lua syntax/static tested only; LDPlayer gameplay not yet validated.
-- NKMPJ HUB V8.1.6 | CORE HOTFIX
-- FIX: initialized missing Live Size telemetry counters in V8.1.3 hybrid core.
-- Previously first Live Size read caused nil arithmetic, and farm stopped itself.
-- No changes to click pacing, Reset/Map implementation, Mouse Override or original logo.
-- Retains compact 4-tab UI, Quick HUD, true X exit and event-driven Live Size.
-- Static and simulated checks only: Delta/LDPlayer validation pending.
-- NKMPJ HUB V8.1.6: CORE RESTORE / COMPACT UX / ORIGINAL LOGO
-- Farm click/reset/map/mouse core from user-tested V7.9.4. V8.1.x Compact UI retained.
-- Event-driven Live Size + Quick HUD, status/history adapter; automatic map SKIP one-shot until growth.
-- Developer review only; NOT validated in live Delta/LDPlayer. Preserve a working backup.
-- NKMPJ HUB V8.1.6 | RESTORE CORE + FULL COMPACT UI | ONE FILE
-- V8.1.1 display-only pass: original logo unchanged, increased visible size and smooth sampling.
-- V8.1.0 includes 12 UX/stability additions; original V7.9.11 farm engine intact.
-- UI/UX only on tested V7.9.11 core: compact-only window (~339px on common desktop),
-- 4 themed icon tabs, organized Home/Stats/System/Style, cleaner status/control cards,
-- full-precision live size, on-demand detailed analytics, and advanced command deck.
-- Keeps the V7.9.11 click, map/reset, live binding, pointer override and shutdown logic.
-- No graphics override, no FPS unlock, no additional farm or render loops.
-- Built on V7.9.11 CLEAN STABLE. No POTATO or FPS-unlocker code.
-- 12-integrated upgrades: frame-gap telemetry, map transition timing,
-- bounded memory sampling, connection retirement, duplicate-command guards,
-- weak GUI text-cache, visible-only render, bounded event logger,
-- Text-changed Live Size, diff-only UI writes, transition phase protection,
-- and low-frequency health samples on the existing 2-second telemetry tick.
-- Live size is event-driven + the existing 10Hz fallback; UI paint is coalesced
-- to <=60Hz to protect flow click timing. Zero does not wait for a throttle.
-- NO additional farm click loop and NO forced graphics/frame-rate changes.
-- Restores the proven pre-graphics runtime; graphics feature is fully removed.
-- V7.9.7 farm engine unchanged. Quick HUD alone receives snapshots in Quick mode;
-- the hidden Full Console is not repainted until opened. No Quick title animation.
-- Quick HUD X uses the same full destructor as Full Console X (stops automation).
-- The Quick minus still minimizes to mini orb, while square opens Full Console.
-- Conservative performance pass over V7.9.6.1: one instance, bounded GUI cache,
-- telemetry piggybacked on existing callbacks, snapshot-only HUD benchmarking.
-- LIVE SIZE follows event-driven game Text changes; chart and heavy HUD stay mouse-wake only.
-- Click cadence, reset/map execution, and mouse override remain unchanged.
-- Built from V7.9.5; never touch its click timing, auto reset/map, or mouse pause detection.
-- V7.9.11: live CURRENT SIZE is event-driven; chart and heavy stats stay mouse-wake only.
-- Faster recovery is bounded: still require two consecutive zero reads and SKIP GUI event.
-- Core remains active while idle; rate samples collected every 2s without drawing. Backup: V7.9.5.
-- Built on V7.9.3 (120 CPS tested). Five additions: click cadence, guard,
-- seamless recovery, low-overhead progress sampling, opt-in experimental rates high-speed lab.
-- Laboratory rates are NEVER enabled automatically; real growth is authoritative.
-- Stable backup: V7.9.3. Game/Delta/LDPlayer live validation still required.
-- BASE: V7.8.6 CELESTIAL LUXE (same proven Auto Farm / Auto Reset / Auto Map).
-- REMOVED: Map Finder / Map IQ / Map Auditor / automatic map voting / auto rewards.
-- DEFAULT: existing STABLE profile (55 clicks/s, 7s stall probe, 10s grace, 30s map cooldown).
-- The GUI, existing farm/reset/skip implementation, and manual reward collection are preserved.
-- V7.9.2 proven manual mouse override preserved: player movement pauses; idle 3s resumes.
-- V7.9.5 Adaptive Turbo measures REAL size gain (not desired CPS), tests 55..120 CPS,
-- selects a conservative winner only with enough valid evidence; otherwise defaults to 55.
-- No reward claiming, voting, map-name scanner, unbounded click flooding, or extra farm thread.
-- Note: Roblox Android on LDPlayer may not expose all Windows desktop mouse movement to UserInputService.
-- Live Delta/LDPlayer testing is required.
-- Single-instance session guard. The earlier V7.9.x UI destructor already
-- retires legacy sessions; this key makes V7.9.7 repeated injection explicit.
local SESSION_KEY='NKMPJ_TITAN_ACTIVE_SESSION'
local previousSession=rawget(_G,SESSION_KEY)
if type(previousSession)=='table' then
 if type(previousSession.shutdown)=='function' then
  local ok,err=pcall(previousSession.shutdown)
  if not ok then warn('NKMPJ previous session shutdown: '..tostring(err)) end
 end
 previousSession.alive=false
end
local titanSession={alive=true,version='8.1.17.4',startedAt=os.clock()}
_G[SESSION_KEY]=titanSession
-- On re-execute, shut down the PREVIOUS UI/core BEFORE the new farm core binds keys.
do
 local retired={}
 for _,key in ipairs({'NKMPJ_V71_UI','NKMPJ_V7_UI'}) do
  local prior=rawget(_G,key)
  if type(prior)=='table' and type(prior.destroy)=='function' and not retired[prior] then
   retired[prior]=true
   local ok,err=pcall(prior.destroy)
   if not ok then warn('NKMPJ previous UI cleanup: '..tostring(err)) end
  end
 end
 -- The old UI destructor also shuts down its farm core. Remove the stale pointer
 -- so startup will not shut it down a second time or unbind newly registered keys.
  -- If the separate V2 map scanner was used, retire only that diagnostic
  -- overlay.  It is not part of the farm core and must not keep scanning.
  local oldScanner=rawget(_G,'NKMPJ_MAP_SCANNER_PRO')
  if type(oldScanner)=='table' and type(oldScanner.destroy)=='function' then
   local ok,err=pcall(oldScanner.destroy)
   if not ok then warn('NKMPJ scanner cleanup: '..tostring(err)) end
  end
  _G.NKMPJ_MAP_SCANNER_PRO=nil
  pcall(function()
   local player=game:GetService('Players').LocalPlayer
   local root=player and player:FindFirstChildOfClass('PlayerGui')
   local scannerGui=root and root:FindFirstChild('NKMPJ_MapScannerPro')
   if scannerGui then scannerGui:Destroy() end
  end)
 local oldcore=rawget(_G,'ETW_HUB_TH')
 if type(oldcore)=='table' and oldcore.alive==false then _G.ETW_HUB_TH=nil end
end
-- Preserve original proven farm engine; entirely new UI.
-- NKMPJ HUB V6.7 | ORION x CRYPGAME | FULL SINGLE LUA
-- NKMPJ HUB V6.6 | ONE FILE | ROYAL COMMAND CONSOLE
-- GUI redesign + embedded 512px master icon. No sound. Stable farm core unchanged.

local function bootStableFarmEngine()
-- NKMPJ HUB V5.4 | OBSIDIAN DOCK | Reference-led professional HUD
-- Based on working V5.3: replaced UI shell; preserved farm/reset/map behavior.
-- Readable source: use your own trusted GitHub Gist as the one-line loader.
local Players=game:GetService("Players")
local UIS=game:GetService("UserInputService")
local GuiService=game:GetService("GuiService")
local CAS=game:GetService("ContextActionService")
local pg=Players.LocalPlayer:WaitForChild("PlayerGui")
-- Stop the older working build before removing its window.
if _G.ETW_RUN then _G.ETW_RUN.on=false;_G.ETW_RUN.alive=false end
if _G.ETW then _G.ETW.on=false;_G.ETW.alive=false end
-- Prevent old farm loops from surviving a re-execute.
local previous=_G.ETW_HUB_TH
if previous and previous.close then pcall(previous.close) end
for _,n in ipairs({"ETW_AUTO_FIXED","ETW_FARM","ETW_HUB_TH"}) do
 local old=pg:FindFirstChild(n);if old then old:Destroy() end
end
local CAP_SAVE_FILE="ETW_HUB_capacity.txt"
local storedCap=tonumber(_G.ETW_MANUAL_CAP)
if (not storedCap or storedCap<1) and type(readfile)=="function" then
 local ok,saved=pcall(readfile,CAP_SAVE_FILE)
 if ok then storedCap=tonumber(saved) end
end
if not storedCap or storedCap<1 then storedCap=nil end
local function persistCapacity(n)
 if type(writefile)=="function" then
  pcall(writefile,CAP_SAVE_FILE,n and tostring(n) or "AUTO")
 end
end
local st={alive=true,on=false,eat=true,reset=true,map=true,rate=5,stalls=0,
 manualCap=storedCap,actualRate=0,clickCount=0,resetPending=false,resetTries=0,
 mapBusy=false,manualRefreshAt=nil,noticeUntil=0,generation=0,calibrating=false,
 menuPoint=_G.ETW_MENU_POINT,skipPoint=_G.ETW_SKIP_POINT,skipCalibrating=false}
_G.ETW_HUB_TH=st
-- Session counters never reset when a map changes or the sell bar returns to zero.
st.hubStartedAt=os.clock()
st.activeStart=nil
st.activeTotal=0
st.gainedSize=0
st.gainedCubes=0
st.lastTrackedSize=nil
st.lastTrackedCubes=nil
st.resetCount=0
st.mapCount=0
st.lastMapAttempt=-math.huge
st.stallProbeSeconds=5
st.stallGraceSeconds=7
st.mapAttemptCooldown=20
-- V7.9.2: Manual Override is a SOFT pause. It never toggles st.on,
-- destroys the farm coroutine, or clears session data.
st.manualEnabled=true
st.manualPaused=false
st.manualIdleSeconds=3.0
st.lastManualActivity=-math.huge
st.manualJustResumed=false
st.syntheticPointer=nil
st.lastHumanPointer=nil
-- Adaptive Turbo uses the original single farm coroutine; no extra click tasks.
st.turboEnabled=false -- turned on AFTER the startup STABLE preset is applied
st.turboPhase='OFF'
st.turboMessage='ปิด Adaptive Turbo'
st.turboGainRate=0
st.turboBestRate=120
st.turboBestGain=0
st.turboTrials=0
st.turboWindowSeconds=8
st.turboSettleSeconds=2
st.turboRetrySeconds=15
st.turboRecheckSeconds=360
-- V7.9.4: the working 120 CPS tier remains available and is the lab fallback.
-- All engine input still runs through ONE original tap coroutine.
st.speedLabEnabled=false -- opt-in; 150/180 never used automatically on startup
st.speedLabCooldownUntil=0
st.flowNextClickAt=nil
st.flowDataSamples=0
st.flowLastClickSpacing=0
st.flowReadInterval=.10 -- game GUI sampled at <= 10 Hz, not each click
st.flowLastGrowth=0
st.flowGuardHits=0
st.flowBest120Actual=0
st.flowRecovered=0
local function pauseRunTimer()
 if st.activeStart then
  st.activeTotal=st.activeTotal+math.max(0,os.clock()-st.activeStart)
  st.activeStart=nil
 end
end
local function trackProgress(p,score)
 if not st.on then return end
 if type(p)=="number" then
  if st.lastTrackedSize and p>st.lastTrackedSize then
   st.gainedSize=st.gainedSize+(p-st.lastTrackedSize)
  end
  st.lastTrackedSize=p
 end
 if type(score)=="number" then
  if st.lastTrackedCubes and score>st.lastTrackedCubes then
   st.gainedCubes=st.gainedCubes+(score-st.lastTrackedCubes)
  end
  st.lastTrackedCubes=score
 end
end
local rates={25,40,55,70,85,100,120,150,180}
local vim,vu
pcall(function()vim=game:GetService("VirtualInputManager") end)
pcall(function()vu=game:GetService("VirtualUser") end)

local function ui(class,parent,properties)
 local o=Instance.new(class)
 for k,v in pairs(properties) do o[k]=v end
 o.Parent=parent
 return o
end
-- NKMPJ HUB V5.3: CINEMATIC COMPACT / compact visual shell.
-- Core automation below this block is inherited from V5.1, unchanged.
-- NKMPJ HUB 5.4 / OBSIDIAN DOCK: entirely new compact visual shell.
-- Farm/zero-lock/map/counters below this shell remain unchanged.
local TweenService=game:GetService("TweenService")
local c={
 bg=Color3.fromRGB(7,11,20),surface=Color3.fromRGB(19,29,46),
 surface2=Color3.fromRGB(29,43,62),muted=Color3.fromRGB(146,166,190),
 white=Color3.fromRGB(242,247,255),cyan=Color3.fromRGB(55,217,244),
 mint=Color3.fromRGB(65,220,180),red=Color3.fromRGB(246,107,122),
 gold=Color3.fromRGB(239,191,106),line=Color3.fromRGB(55,83,111),
 blue=Color3.fromRGB(32,118,197),violet=Color3.fromRGB(72,99,179),
 chrome=Color3.fromRGB(198,221,239)
}
local function corner(o,r)
 return ui("UICorner",o,{CornerRadius=UDim.new(0,r or 9)})
end
local function border(o,color,alpha,thick)
 return ui("UIStroke",o,{Color=color or c.line,Transparency=alpha or .48,Thickness=thick or 1})
end
local function label(parent,value,x,y,w,h,fontSize,heavy,color)
 return ui("TextLabel",parent,{Position=UDim2.fromOffset(x,y),Size=UDim2.fromOffset(w,h),
  BackgroundTransparency=1,Text=value,TextColor3=color or c.white,
  TextSize=fontSize or 12,Font=heavy and Enum.Font.GothamBold or Enum.Font.Gotham,
  TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Center,
  TextWrapped=false,TextTruncate=Enum.TextTruncate.AtEnd})
end
local function button(value,x,y,w,h,bg,fontSize,parent)
 local o=ui("TextButton",parent,{Position=UDim2.fromOffset(x,y),Size=UDim2.fromOffset(w,h),
  Text=value,BackgroundColor3=bg or c.surface2,BackgroundTransparency=0,
  TextColor3=c.white,BorderSizePixel=0,TextSize=fontSize or 12,
  Font=Enum.Font.GothamBold,AutoButtonColor=true})
 corner(o,8)
 return o
end
local function glossy(o,left,right,angle)
 return ui("UIGradient",o,{Color=ColorSequence.new({
  ColorSequenceKeypoint.new(0,left),ColorSequenceKeypoint.new(1,right)}),Rotation=angle or 0})
end
local function thinLine(p,x,y,w,color,opacity)
 return ui("Frame",p,{Position=UDim2.fromOffset(x,y),Size=UDim2.fromOffset(w,1),
  BackgroundColor3=color or c.line,BackgroundTransparency=opacity or .35,BorderSizePixel=0})
end
local gui=ui("ScreenGui",pg,{Name="ETW_HUB_TH",ResetOnSpawn=false,
 DisplayOrder=9999,ZIndexBehavior=Enum.ZIndexBehavior.Sibling})
local view=workspace.CurrentCamera.ViewportSize
-- Compact dock: sidebar + hero, almost half the footprint of the old V5.2.
local W,H=366,305
local s=math.clamp(math.min((view.X-12)/W,(view.Y-12)/H),.7,1)
local px=math.max(4,view.X-W*s-16)
local py=math.max(4,math.min(20,view.Y-H*s-12))
local shadow=ui("Frame",gui,{Name="DockShadow",Size=UDim2.fromOffset(W+12,H+12),
 Position=UDim2.fromOffset(px-6,py+6),BackgroundColor3=Color3.fromRGB(0,3,10),
 BackgroundTransparency=.52,BorderSizePixel=0})
corner(shadow,19)
ui("UIScale",shadow,{Scale=s})
local panel=ui("Frame",gui,{Name="NKMPJ_Obsidian_Dock",Size=UDim2.fromOffset(W,H),
 Position=UDim2.fromOffset(px,py),BackgroundColor3=c.bg,BorderSizePixel=0,
 BackgroundTransparency=0,ClipsDescendants=true})
corner(panel,14)
ui("UIScale",panel,{Scale=s})
border(panel,Color3.fromRGB(96,139,169),.43,1)
glossy(panel,Color3.fromRGB(13,22,36),Color3.fromRGB(5,9,18),92)
-- Distinct vertical navigation rail with a monogram reactor.
local rail=ui("Frame",panel,{Name="DockRail",Position=UDim2.fromOffset(0,0),
 Size=UDim2.fromOffset(57,H),BackgroundColor3=Color3.fromRGB(11,20,34),BorderSizePixel=0})
glossy(rail,Color3.fromRGB(19,37,57),Color3.fromRGB(9,16,28),90)
local railDivider=ui("Frame",panel,{Position=UDim2.fromOffset(56,0),Size=UDim2.fromOffset(1,H),
 BackgroundColor3=Color3.fromRGB(48,81,106),BackgroundTransparency=.45,BorderSizePixel=0})
local crest=ui("Frame",rail,{Name="BrandMark",Position=UDim2.fromOffset(9,12),
 Size=UDim2.fromOffset(39,39),BackgroundColor3=Color3.fromRGB(16,58,77),BorderSizePixel=0})
corner(crest,11)
local logoStroke=border(crest,c.cyan,.13,1.35)
glossy(crest,Color3.fromRGB(36,122,153),Color3.fromRGB(12,37,64),60)
local monogram=label(crest,"N",0,0,39,39,23,true,c.white)
monogram.TextXAlignment=Enum.TextXAlignment.Center
local nav=ui("Frame",rail,{Name="SectionNavigation",Position=UDim2.fromOffset(5,77),
 Size=UDim2.fromOffset(47,167),BackgroundTransparency=1})
local tabMain=button("01",3,0,41,43,Color3.fromRGB(25,79,102),13,nav)
local tabDetail=button("02",3,52,41,43,Color3.fromRGB(21,34,51),13,nav)
local tabSettings=button("03",3,104,41,43,Color3.fromRGB(21,34,51),13,nav)
local tabUnderline=ui("Frame",nav,{Position=UDim2.fromOffset(0,7),
 Size=UDim2.fromOffset(2,28),BackgroundColor3=c.cyan,BorderSizePixel=0})
corner(tabUnderline,2)
label(rail,"v5.4",9,274,43,13,9,true,c.muted).TextXAlignment=Enum.TextXAlignment.Center
-- Logo strip with a short LED light trail and large readable branding.
local head=ui("Frame",panel,{Name="DragHandle",Position=UDim2.fromOffset(57,0),
 Size=UDim2.fromOffset(309,56),BackgroundColor3=Color3.fromRGB(14,26,43),
 BorderSizePixel=0,Active=true,ClipsDescendants=true})
glossy(head,Color3.fromRGB(25,45,67),Color3.fromRGB(10,20,35),5)
local brand=label(head,"NKMPJ HUB ⚡",13,5,224,29,19,true,c.white)
local subtitle=label(head,"OBSIDIAN  /  COMMAND DOCK",14,32,220,13,9,true,c.cyan)
local miniButton=button("–",246,13,26,27,Color3.fromRGB(29,49,67),16,head)
local closeButton=button("×",278,13,25,27,Color3.fromRGB(76,34,49),16,head)
local ledBack=ui("Frame",panel,{Name="LiveEdge",Position=UDim2.fromOffset(70,56),
 Size=UDim2.fromOffset(280,2),BackgroundColor3=c.cyan,BorderSizePixel=0})
local ledGradient=ui("UIGradient",ledBack,{Color=ColorSequence.new({
 ColorSequenceKeypoint.new(0,Color3.fromRGB(14,40,54)),
 ColorSequenceKeypoint.new(.44,Color3.fromRGB(38,123,160)),
 ColorSequenceKeypoint.new(.5,c.cyan),
 ColorSequenceKeypoint.new(.56,Color3.fromRGB(38,123,160)),
 ColorSequenceKeypoint.new(1,Color3.fromRGB(14,40,54))}),Offset=Vector2.new(-.25,0)})
-- Content is narrower than the outer shell. No oversized empty cards.
local mainPage=ui("Frame",panel,{Name="Overview",Position=UDim2.fromOffset(68,66),
 Size=UDim2.fromOffset(287,205),BackgroundTransparency=1})
local detailPage=ui("Frame",panel,{Name="Analytics",Position=UDim2.fromOffset(68,66),
 Size=UDim2.fromOffset(287,205),BackgroundTransparency=1,Visible=false})
local settingsPage=ui("ScrollingFrame",panel,{Name="Settings",Position=UDim2.fromOffset(68,66),
 Size=UDim2.fromOffset(287,205),CanvasSize=UDim2.fromOffset(287,482),
 BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=3,
 ScrollBarImageColor3=c.cyan,ScrollingDirection=Enum.ScrollingDirection.Y,Visible=false})
-- A slim live-status bar over the main numeric hero.
local statusBadge=ui("Frame",mainPage,{Name="Status",Position=UDim2.fromOffset(0,0),
 Size=UDim2.fromOffset(287,27),BackgroundColor3=Color3.fromRGB(19,38,55),BorderSizePixel=0})
corner(statusBadge,8)
local accentDot=ui("Frame",statusBadge,{Position=UDim2.fromOffset(11,10),
 Size=UDim2.fromOffset(7,7),BackgroundColor3=c.gold,BorderSizePixel=0})
corner(accentDot,4)
local activity=label(statusBadge,"พร้อมใช้งาน",25,3,168,21,11,true,c.white)
local sessionTiny=label(statusBadge,"00:00:00",195,3,82,21,11,true,c.muted)
sessionTiny.TextXAlignment=Enum.TextXAlignment.Right
local stats=ui("Frame",mainPage,{Name="ReactorCapacity",Position=UDim2.fromOffset(0,34),
 Size=UDim2.fromOffset(287,96),BackgroundColor3=Color3.fromRGB(14,35,56),
 BorderSizePixel=0,ClipsDescendants=true})
corner(stats,10)
border(stats,Color3.fromRGB(74,138,164),.53,1)
glossy(stats,Color3.fromRGB(25,59,80),Color3.fromRGB(12,27,45),3)
local heroEdge=ui("Frame",stats,{Position=UDim2.fromOffset(246,-32),
 Size=UDim2.fromOffset(16,158),Rotation=23,
 BackgroundColor3=Color3.fromRGB(96,197,229),BackgroundTransparency=.92,BorderSizePixel=0})
label(stats,"ขนาดตัวละคร",11,6,182,16,11,true,c.chrome)
local capPercent=label(stats,"0.0%",207,6,69,16,12,true,c.cyan)
capPercent.TextXAlignment=Enum.TextXAlignment.Right
local info=label(stats,"กำลังอ่านข้อมูล...",11,25,265,29,24,true,c.white)
local capHint=label(stats,"ขนาดสูงสุด -",11,55,265,13,10,false,c.muted)
local progressBack=ui("Frame",stats,{Position=UDim2.fromOffset(11,80),
 Size=UDim2.fromOffset(265,7),BackgroundColor3=Color3.fromRGB(32,64,81),
 BorderSizePixel=0,ClipsDescendants=true})
corner(progressBack,4)
local progressFill=ui("Frame",progressBack,{Size=UDim2.fromScale(0,1),
 BackgroundColor3=c.cyan,BorderSizePixel=0})
corner(progressFill,4)
ui("UIGradient",progressFill,{Color=ColorSequence.new({
 ColorSequenceKeypoint.new(0,c.blue),ColorSequenceKeypoint.new(.57,c.cyan),
 ColorSequenceKeypoint.new(1,c.mint)})})
-- One hero action and three very small data cards.
local start=button("เริ่มระบบ",0,138,287,36,Color3.fromRGB(40,182,207),13,mainPage)
start.TextColor3=Color3.fromRGB(6,31,44)
local mainGradient=glossy(start,Color3.fromRGB(100,226,240),Color3.fromRGB(44,156,199),7)
border(start,c.cyan,.62,1)
local function smallTile(x,title)
 local f=ui("Frame",mainPage,{Position=UDim2.fromOffset(x,181),
  Size=UDim2.fromOffset(91,24),BackgroundColor3=Color3.fromRGB(22,36,55),BorderSizePixel=0})
 corner(f,7)
 label(f,title,7,1,82,10,9,false,c.muted)
 return label(f,"-",7,11,82,13,12,true,c.white)
end
local summaryGain=smallTile(0,"ขนาดเพิ่ม")
local summaryFarmTime=smallTile(98,"เวลาฟาร์ม")
local summaryMaps=smallTile(196,"แมพ")
-- Analytics: four compact counters and a real 12-sample chart.
local rateCaption=label(detailPage,"ความเร็วจริง / ตั้งค่า",0,0,277,17,11,true,c.muted)
local function metricCard(x,y,caption,initial)
 local card=ui("Frame",detailPage,{Position=UDim2.fromOffset(x,y),
  Size=UDim2.fromOffset(139,42),BackgroundColor3=c.surface,BorderSizePixel=0})
 corner(card,7)
 label(card,caption,8,2,127,15,10,false,c.muted)
 return label(card,initial,8,18,127,20,15,true,c.white)
end
local sizeGainLabel=metricCard(0,20,"ขนาดเพิ่มทั้งหมด","+0")
local cubeGainLabel=metricCard(148,20,"แต้มที่เพิ่ม","+0")
local farmTimeLabel=metricCard(0,66,"เวลาฟาร์มจริง","00:00:00")
local mapCountLabel=metricCard(148,66,"เปลี่ยนแมพ","0")
local chart=ui("Frame",detailPage,{Position=UDim2.fromOffset(0,113),
 Size=UDim2.fromOffset(287,62),BackgroundColor3=c.surface,BorderSizePixel=0})
corner(chart,7)
label(chart,"ความเร็วคลิกย้อนหลัง",9,3,204,14,10,true,c.muted)
local plotNumber=label(chart,"0 /s",225,3,53,14,10,true,c.cyan)
plotNumber.TextXAlignment=Enum.TextXAlignment.Right
thinLine(chart,9,51,269,c.line,.73)
local rateBars={}
for i=1,12 do
 local bar=ui("Frame",chart,{Position=UDim2.fromOffset(11+(i-1)*21,40),
  Size=UDim2.fromOffset(14,3),BackgroundColor3=(i%3==0) and c.blue or c.cyan,
  BackgroundTransparency=.12,BorderSizePixel=0})
 corner(bar,2)
 rateBars[#rateBars+1]=bar
end
local lastBarAt=0
local rateSamples={}
for i=1,12 do rateSamples[i]=0 end
local detailSummary=label(detailPage,"",0,179,185,12,10,false,c.muted)
local round=label(detailPage,"รีเซ็ต 0 / ค้าง 0/2",0,193,185,12,10,false,c.muted)
local manualMap=button("ทดสอบแมพ",191,181,96,26,Color3.fromRGB(30,80,99),10,detailPage)
-- Same setting controls and identifiers; only the geometry and sections change.
label(settingsPage,"ระบบอัตโนมัติ",0,0,279,18,12,true,c.white)
local e=button("ฟาร์ม : ON",0,22,90,30,c.surface2,10,settingsPage)
local r=button("รีเซ็ต : ON",97,22,91,30,c.surface2,10,settingsPage)
local m=button("แมพ : ON",195,22,91,30,c.surface2,10,settingsPage)
label(settingsPage,"ความเร็วการทำงาน",0,62,280,18,12,true,c.white)
local slower=button("−",0,85,36,31,c.surface2,17,settingsPage)
local rateLabel=label(settingsPage,"85 ครั้ง/วิ",42,83,200,36,14,true,c.cyan)
rateLabel.TextXAlignment=Enum.TextXAlignment.Center
local faster=button("+",250,85,36,31,c.surface2,17,settingsPage)
local probeCaption=label(settingsPage,"ตรวจทุก 5 วิ • ค้าง 2 รอบ • พักหลังเปลี่ยนแมพ",0,123,283,31,10,false,c.muted)
probeCaption.TextWrapped=true
thinLine(settingsPage,0,158,283,c.line,.53)
label(settingsPage,"ขนาดสูงสุด",0,164,281,19,12,true,c.white)
local capBox=ui("TextBox",settingsPage,{Position=UDim2.fromOffset(0,189),
 Size=UDim2.fromOffset(158,32),BackgroundColor3=c.surface2,BorderSizePixel=0,
 Text=st.manualCap and tostring(st.manualCap) or "",PlaceholderText="7,469,100",
 PlaceholderColor3=c.muted,TextColor3=c.white,TextSize=11,Font=Enum.Font.Gotham,
 TextXAlignment=Enum.TextXAlignment.Center,ClearTextOnFocus=false})
corner(capBox,7)
local applyCap=button("บันทึก",164,189,58,32,Color3.fromRGB(28,105,119),10,settingsPage)
local autoCap=button("AUTO",228,189,58,32,c.surface2,10,settingsPage)
local capacityMode=label(settingsPage,"อ่านค่าจากเกมอัตโนมัติ",0,227,282,17,10,false,c.cyan)
thinLine(settingsPage,0,255,283,c.line,.53)
label(settingsPage,"ปุ่มควบคุม",0,262,279,19,12,true,c.white)
label(settingsPage,"HOME เริ่ม/หยุด    END หยุดทันที",0,284,281,19,11,false,c.muted)
label(settingsPage,"ใช้ Keyboard Mapping เมื่อเล่นผ่าน LDPlayer",0,305,280,17,10,false,c.muted)
local calibrate=button("ตรวจเมนู",0,334,139,31,c.surface2,10,settingsPage)
local calibrateSkip=button("ตรวจ SKIP",146,334,140,31,c.surface2,10,settingsPage)
local resetStats=button("ล้างสถิติ",0,373,139,31,c.surface2,10,settingsPage)
local emergency=button("หยุดทันที",146,373,140,31,Color3.fromRGB(82,42,51),10,settingsPage)
local fxBtn=button("แสงและแอนิเมชัน : ON",0,413,286,34,Color3.fromRGB(23,71,91),11,settingsPage)
-- A thin unobtrusive message bar.
local footer=ui("Frame",panel,{Position=UDim2.fromOffset(68,279),
 Size=UDim2.fromOffset(287,18),BackgroundColor3=Color3.fromRGB(12,24,38),BorderSizePixel=0})
corner(footer,5)
local message=label(footer,"พร้อมเริ่มระบบ",7,0,273,18,10,false,c.mint)
-- EXACTLY ONE button remains after collapsing: 44x44 monogram.
local bubble=ui("TextButton",gui,{Name="NKMPJ_LogoOnly",Size=UDim2.fromOffset(44,44),
 Position=panel.Position,Visible=false,Text="N",TextSize=25,Font=Enum.Font.GothamBold,
 TextColor3=c.white,BackgroundColor3=Color3.fromRGB(16,60,83),BorderSizePixel=0})
corner(bubble,13)
border(bubble,c.cyan,.2,1.25)
glossy(bubble,Color3.fromRGB(31,113,145),Color3.fromRGB(9,30,54),68)
-- Kept as an invisible legacy binding target, never placed on the game screen.
local floating=ui("TextButton",gui,{Name="LegacyHiddenControl",Size=UDim2.fromOffset(1,1),
 Position=panel.Position,Visible=false,Text="START",TextSize=9,
 TextColor3=c.white,BackgroundTransparency=1,BorderSizePixel=0})
local pulse=TweenService:Create(accentDot,TweenInfo.new(2.6,Enum.EasingStyle.Sine,
 Enum.EasingDirection.InOut,-1,true),{BackgroundTransparency=.67})
local ledFlow=TweenService:Create(ledGradient,TweenInfo.new(7.5,Enum.EasingStyle.Sine,
 Enum.EasingDirection.InOut,-1,true),{Offset=Vector2.new(.4,0)})
local logoPulse=TweenService:Create(logoStroke,TweenInfo.new(3.8,Enum.EasingStyle.Sine,
 Enum.EasingDirection.InOut,-1,true),{Transparency=.7})
st.fx=(_G.NKMPJ_HUB_FX~=false)
local function applyEffects()
 if st.fx then
  pulse:Play();ledFlow:Play();logoPulse:Play()
  ledBack.BackgroundTransparency=0
  fxBtn.Text="แสงและแอนิเมชัน : ON"
  fxBtn.BackgroundColor3=Color3.fromRGB(23,71,91)
 else
  pulse:Cancel();ledFlow:Cancel();logoPulse:Cancel()
  accentDot.BackgroundTransparency=0
  logoStroke.Transparency=.25
  ledGradient.Offset=Vector2.new(0,0)
  ledBack.BackgroundTransparency=.46
  fxBtn.Text="แสงและแอนิเมชัน : OFF"
  fxBtn.BackgroundColor3=c.surface2
 end
end
fxBtn.Activated:Connect(function()
 st.fx=not st.fx;_G.NKMPJ_HUB_FX=st.fx;applyEffects()
end)
applyEffects()
local function selectPage(which)
 mainPage.Visible=which=="main"
 detailPage.Visible=which=="detail"
 settingsPage.Visible=which=="settings"
 local active=Color3.fromRGB(29,97,121)
 local idle=Color3.fromRGB(21,34,51)
 tabMain.BackgroundColor3=which=="main" and active or idle
 tabDetail.BackgroundColor3=which=="detail" and active or idle
 tabSettings.BackgroundColor3=which=="settings" and active or idle
 local y=which=="main" and 7 or (which=="detail" and 59 or 111)
 TweenService:Create(tabUnderline,TweenInfo.new(.2,Enum.EasingStyle.Quad,
  Enum.EasingDirection.Out),{Position=UDim2.fromOffset(0,y)}):Play()
end
tabMain.Activated:Connect(function()selectPage("main")end)
tabDetail.Activated:Connect(function()selectPage("detail")end)
tabSettings.Activated:Connect(function()selectPage("settings")end)
-- Dragging: the header moves the window; the mini monogram also drags.
local moving,dragOrigin,initialPos,movingHandle,dragTouch,dragged=false,nil,nil,nil,nil,false
local connections={}
local function beginDrag(handle,target)
 table.insert(connections,handle.InputBegan:Connect(function(input)
  if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
   moving=true;movingHandle=target;dragOrigin=input.Position;initialPos=target.Position
   dragTouch=input.UserInputType==Enum.UserInputType.Touch and input or nil;dragged=false
  end
 end))
end
beginDrag(head,panel)
beginDrag(bubble,bubble)
table.insert(connections,UIS.InputChanged:Connect(function(input)
 if not moving then return end
 if (dragTouch and input~=dragTouch) or
   (not dragTouch and input.UserInputType~=Enum.UserInputType.MouseMovement) then return end
 local delta=input.Position-dragOrigin
 if delta.Magnitude>6 then dragged=true end
 local vw,vh=workspace.CurrentCamera.ViewportSize.X,workspace.CurrentCamera.ViewportSize.Y
 local nx=math.clamp(initialPos.X.Offset+delta.X,0,math.max(0,vw-movingHandle.AbsoluteSize.X))
 local ny=math.clamp(initialPos.Y.Offset+delta.Y,0,math.max(0,vh-movingHandle.AbsoluteSize.Y))
 movingHandle.Position=UDim2.fromOffset(nx,ny)
 if movingHandle==panel then
  shadow.Position=UDim2.fromOffset(nx-6,ny+6)
 end
end))
table.insert(connections,UIS.InputEnded:Connect(function(input)
 if moving and ((dragTouch and input==dragTouch) or
   (not dragTouch and input.UserInputType==Enum.UserInputType.MouseButton1)) then
  moving=false;dragTouch=nil
 end
end))
function st.close()
 if st.closed then return end
 st.closed=true
 if st.activeStart then
  st.activeTotal=st.activeTotal+math.max(0,os.clock()-st.activeStart)
  st.activeStart=nil
 end
 st.on=false;st.alive=false
 for _,conn in ipairs(connections) do pcall(function()conn:Disconnect()end) end
 pcall(function()CAS:UnbindAction("ETW_HUB_HOME")end)
 pcall(function()CAS:UnbindAction("ETW_HUB_END")end)
 pcall(function()pulse:Cancel()end)
 pcall(function()ledFlow:Cancel()end)
 pcall(function()logoPulse:Cancel()end)
 gui:Destroy()
 if _G.ETW_HUB_TH==st then _G.ETW_HUB_TH=nil end
end
closeButton.Activated:Connect(st.close)
miniButton.Activated:Connect(function()
 bubble.Position=panel.Position
 shadow.Visible=false
 panel.Visible=false
 bubble.Visible=true
 floating.Visible=false
end)
bubble.Activated:Connect(function()
 if dragged then dragged=false;return end
 local vw,vh=workspace.CurrentCamera.ViewportSize.X,workspace.CurrentCamera.ViewportSize.Y
 local nx=math.clamp(bubble.Position.X.Offset,0,math.max(0,vw-W*s))
 local ny=math.clamp(bubble.Position.Y.Offset,0,math.max(0,vh-H*s))
 panel.Position=UDim2.fromOffset(nx,ny)
 shadow.Position=UDim2.fromOffset(nx-6,ny+6)
 bubble.Visible=false
 floating.Visible=false
 panel.Visible=true
 shadow.Visible=true
end)
local function clockText(sec)
 sec=math.floor(math.max(0,sec or 0))
 return string.format("%02d:%02d:%02d",math.floor(sec/3600),math.floor(sec/60)%60,sec%60)
end
local function numberForDisplay(n)
 if n==nil then return "-" end
 local digits=tostring(math.floor(n)):reverse():gsub("(%d%d%d)","%1,"):reverse()
 return digits:gsub("^,","")
end
-- Keep tiny overview cards readable; full exact totals remain on Stats tab.
local function shortNumber(n)
 n=tonumber(n) or 0
 if n>=1000000000 then return string.format("%.2fB",n/1000000000) end
 if n>=1000000 then return string.format("%.2fM",n/1000000) end
 if n>=10000 then return string.format("%.1fK",n/1000) end
 return numberForDisplay(n)
end
local function updateButtons()
 e.Text="ฟาร์ม : "..(st.eat and "ON" or "OFF")
 r.Text="รีเซ็ต : "..(st.reset and "ON" or "OFF")
 m.Text="แมพ : "..(st.map and "ON" or "OFF")
 local yes=Color3.fromRGB(21,83,92)
 local no=Color3.fromRGB(40,50,65)
 e.BackgroundColor3=st.eat and yes or no
 r.BackgroundColor3=st.reset and yes or no
 m.BackgroundColor3=st.map and yes or no
 accentDot.BackgroundColor3=st.on and c.mint or c.gold
 start.Text=st.on and "หยุดระบบ" or "เริ่มระบบ"
 start.BackgroundColor3=st.on and Color3.fromRGB(38,70,93) or c.mint
 start.TextColor3=st.on and c.white or c.bg
 mainGradient.Enabled=not st.on
 floating.Text=st.on and "STOP" or "START"
 floating.BackgroundColor3=st.on and c.red or c.mint
 floating.TextColor3=st.on and c.white or c.bg
 bubble.Text="N"
 activity.Text=st.manualPaused and "ผู้ใช้ควบคุมเมาส์" or (st.on and "กำลังฟาร์ม" or "พร้อมใช้งาน")
 rateLabel.Text=tostring(rates[st.rate]).." ครั้ง/วิ"
end
for _,entry in ipairs({{e,"eat"},{r,"reset"},{m,"map"}}) do
 entry[1].Activated:Connect(function()
  st[entry[2]]=not st[entry[2]];updateButtons()
 end)
end
slower.Activated:Connect(function()
 st.turboEnabled=false;st.turboPhase='OFF';st.turboMessage='MANUAL • ปรับความเร็วเอง'
 st.rate=math.max(1,st.rate-1);updateButtons()
end)
faster.Activated:Connect(function()
 st.turboEnabled=false;st.turboPhase='OFF';st.turboMessage='MANUAL • ปรับความเร็วเอง'
 st.rate=math.min(7,st.rate+1);updateButtons()
end)
local lastProgressAnimation=0
local lastProgressTween=nil
local function updateMetrics(p,cap,score,elapsedText)
 if p~=nil then st.lastDisplaySize=p end
 if cap~=nil then st.lastDisplayCapacity=cap end
 if score~=nil then st.lastDisplayCubes=score end
 local size=st.lastDisplaySize
 local maxSize=st.lastDisplayCapacity
 local ratio=maxSize and maxSize>0 and math.clamp((size or 0)/maxSize,0,1) or 0
 info.Text=numberForDisplay(size)
 capHint.Text="ขนาดสูงสุด  "..numberForDisplay(maxSize)
 capPercent.Text=string.format("%.1f%%",ratio*100)
 if st.fx and os.clock()-lastProgressAnimation>.65 and
    (not st.lastProgressRatio or math.abs(ratio-st.lastProgressRatio)>.01) then
  if lastProgressTween then lastProgressTween:Cancel()end
  lastProgressTween=TweenService:Create(progressFill,TweenInfo.new(.35,Enum.EasingStyle.Quad,
   Enum.EasingDirection.Out),{Size=UDim2.fromScale(ratio,1)})
  lastProgressTween:Play()
  lastProgressAnimation=os.clock()
 elseif not st.fx then
  progressFill.Size=UDim2.fromScale(ratio,1)
 end
 st.lastProgressRatio=ratio
 sizeGainLabel.Text="+"..numberForDisplay(st.gainedSize or 0)
 cubeGainLabel.Text="+"..numberForDisplay(st.gainedCubes or 0)
 local running=(st.activeTotal or 0)+(st.on and st.activeStart and (os.clock()-st.activeStart) or 0)
 farmTimeLabel.Text=clockText(running)
 mapCountLabel.Text=tostring(st.mapCount or 0).." ครั้ง"
 summaryGain.Text="+"..shortNumber(st.gainedSize or 0)
 summaryFarmTime.Text=clockText(running)
 summaryMaps.Text=tostring(st.mapCount or 0)
 sessionTiny.Text=clockText(os.clock()-(st.hubStartedAt or os.clock()))
 bubble.Text="N"
 round.Text="รีเซ็ต "..tostring(st.resetCount or 0).."  /  ค้าง "..tostring(st.stalls).."/2"
 detailSummary.Text="ความเร็วจริง "..tostring(st.actualRate or 0).."  /  เป้าหมาย "..tostring(rates[st.rate]).." คลิก/วิ"
 rateCaption.Text="ความเร็วคลิกจริง "..tostring(st.actualRate or 0).."  /  "..tostring(rates[st.rate]).." เป้าหมาย"
 plotNumber.Text=tostring(st.actualRate or 0).." /s"
 if os.clock()-lastBarAt>=2 then
  lastBarAt=os.clock()
  table.remove(rateSamples,1)
  rateSamples[#rateSamples+1]=st.on and (st.actualRate or 0) or 0
  for i,bar in ipairs(rateBars) do
   local h=math.max(3,math.floor(math.clamp(rateSamples[i]/math.max(1,rates[st.rate]),0,1)*19))
   bar.Size=UDim2.fromOffset(14,h)
   bar.Position=UDim2.fromOffset(11+(i-1)*21,51-h)
  end
 end
end
updateButtons()
task.spawn(function()
 while st.alive do
  -- Hidden legacy shell: refresh only every 1.8s (visual V7 layer is separate).
  updateMetrics(nil,nil,nil,nil)
  task.wait(1.8)
 end
end)

-- Manual pause guard is assigned after the core message functions are defined.
-- All synthetic pointer calls in the farm engine go through this guard.
local waitForManualIdle, markScriptPointer
-- Preserve input methods from the previously working Auto Farm Fix.
local function tap(x,y,hold)
 x=math.floor(x);y=math.floor(y);hold=hold or .006
 if waitForManualIdle and not waitForManualIdle() then return false end
 if markScriptPointer then markScriptPointer(x,y) end
 if vim then
  local ok=pcall(function()
   vim:SendMouseButtonEvent(x,y,0,true,game,0)
   task.wait(hold)
   vim:SendMouseButtonEvent(x,y,0,false,game,0)
  end)
  if ok then return true end
 end
 if vu then
  local ok=pcall(function()
   local camera=workspace.CurrentCamera
   vu:Button1Down(Vector2.new(x,y),camera.CFrame)
   task.wait(hold)
   vu:Button1Up(Vector2.new(x,y),camera.CFrame)
  end)
  if ok then return true end
 end
 return false
end
local function path(...)
 -- Re-resolve after map changes or UI reloads; never retain an old GUI root.
 local o=pg:FindFirstChild("ScreenGui")
 for _,name in ipairs({...}) do
  if not o then return nil end
  o=o:FindFirstChild(name)
 end
 return o
end
local function numeric(o)
 if not o or not o:IsA("TextLabel") and not o:IsA("TextButton") then return nil end
 return tonumber((o.Text:gsub(",","")))
end
local function progress()
 return numeric(path("Sell","ProgressText"))
end
local function capacity()
 -- User override takes precedence, otherwise adapt automatically when game upgrades.
 if st.manualCap and st.manualCap>0 then return st.manualCap end
 return numeric(path("Shop","ShopFrames","Upgrades","UpgradeList","MaxSize","UpgradeFrame","Amount"))
end
local function cubes()
 return numeric(path("Shop","CubeFrame","CounterFrame","Cubes"))
end
-- FLOW CORE / read-only frame snapshot. Avoid resolving nested GUIs on every
-- high-rate click, but never reuse a snapshot across a sell or map transition.
local flowSnapshot={at=-math.huge,p=nil,cap=nil,score=nil}
local function flowInvalidate()
 flowSnapshot.at=-math.huge
 st.flowNextClickAt=nil
end
local function flowRead(now)
 now=now or os.clock()
 if now-flowSnapshot.at>=st.flowReadInterval or now<flowSnapshot.at then
  flowSnapshot.p=progress()
  flowSnapshot.cap=capacity()
  flowSnapshot.score=cubes()
  flowSnapshot.at=now
  st.flowDataSamples=st.flowDataSamples+1
 end
 return flowSnapshot.p,flowSnapshot.cap,flowSnapshot.score
end
-- Populate the dashboard before the user presses START.
updateMetrics(progress(),capacity(),cubes())
resetStats.Activated:Connect(function()
 st.gainedSize=0;st.gainedCubes=0;st.resetCount=0;st.mapCount=0
 st.lastTrackedSize=progress();st.lastTrackedCubes=cubes()
 st.noticeUntil=os.clock()+5
 updateMetrics(progress(),capacity(),cubes())
 message.Text="ล้างสถิติแล้ว • ระบบทำงานต่อ"
 message.TextColor3=c.mint
end)
local function press(o)
 if not o or not o:IsA("GuiObject") then return false end
 local p=o.AbsolutePosition;local s=o.AbsoluteSize
 return tap(p.X+s.X*.5,p.Y+s.Y*.5,.01)
end
local function pause(seconds)
 local generation=st.generation
 local stopAt=os.clock()+seconds
 while st.on and st.alive and st.generation==generation and os.clock()<stopAt do
  if st.manualPaused then
   local began=os.clock()
   if not waitForManualIdle() then return end
   stopAt=stopAt+math.max(0,os.clock()-began)
  end
  task.wait(.08)
 end
end
local function setMessage(s)
 if not st.alive then return end
 -- While user is in control, do not overwrite the visible PAUSED status.
 if st.manualPaused and not s:find("ผู้ใช้ควบคุม",1,true) then return end
 if s=="กำลังกินดิน" and os.clock()<st.noticeUntil then return end
 local rendered=s:gsub("กำลังกินดิน","กำลังฟาร์ม")
  :gsub("กลับไปกิน","กลับไปฟาร์ม")
 local display=rendered
 if s:find("ไม่สำเร็จ",1,true) or s:find("ไม่ได้",1,true)
    or s:find("ข้อผิดพลาด",1,true) or s:find("ฉุกเฉิน",1,true) then
  message.TextColor3=c.red
 elseif s:find("รีเซ็ต",1,true) or s:find("กำลังตรวจ",1,true) then
  message.TextColor3=c.gold
 else
  message.TextColor3=c.mint
 end
 if message.Text~=display then message.Text=display end
 -- Mirror the operational status in the dashboard badge, without altering game logic.
 activity.Text=rendered
 if s:find("รีเซ็ต",1,true) or s:find("ขาย",1,true) then
  accentDot.BackgroundColor3=c.gold
 elseif s:find("แมพ",1,true) or s:find("SKIP",1,true) then
  accentDot.BackgroundColor3=c.cyan
 elseif s:find("ไม่ได้",1,true) or s:find("ผิดพลาด",1,true) then
  accentDot.BackgroundColor3=c.red
 else
  accentDot.BackgroundColor3=st.on and c.mint or c.gold
 end
end

-- ============================================================================
-- V7.9.2 | MANUAL OVERRIDE (passive player input; gameplay automation paused)
-- ============================================================================
-- This can only see pointer/touch events delivered *to Roblox* by LDPlayer.
-- We deliberately do not use global keyboard/mouse hooks or external services.
markScriptPointer=function(x,y)
 st.syntheticPointer={x=tonumber(x) or 0,y=tonumber(y) or 0,untilAt=os.clock()+.24}
end
waitForManualIdle=function()
 local generation=st.generation
 while st.alive and st.on and st.generation==generation and st.manualEnabled and st.manualPaused do
  task.wait(.06)
 end
 return st.alive and st.on and st.generation==generation
end
local function resumeManualPause(reason)
 if not st.manualPaused then return end
 st.manualPaused=false
 st.lastManualActivity=-math.huge
 st.manualJustResumed=true
 flowInvalidate()
 st.actualRate=0
 if st.alive and st.on then
  st.activeStart=os.clock() -- farm time excludes time under the user's control
  setMessage(reason or 'เมาส์นิ่งแล้ว • ฟาร์มต่ออัตโนมัติ')
 end
end
local function enterManualPause()
 if st.manualPaused or not st.on or not st.manualEnabled then return end
 st.manualPaused=true
 pauseRunTimer()
 st.actualRate=0
 st.stalls=0
 flowInvalidate()
 st.noticeUntil=os.clock()+3.1
 setMessage('พักอัตโนมัติ • ผู้ใช้ควบคุมเมาส์')
end
local function syntheticAt(x,y,now)
 local v=st.syntheticPointer
 if not v or now>v.untilAt then return false end
 -- Roblox Android may report a ~58px GUI inset for injected mouse events.
 local dx=math.abs(x-v.x)
 local dy=math.abs(y-v.y)
 return dx<=10 and (dy<=10 or math.abs(dy-58)<=10)
end
local function recordHumanActivity(input,motion)
 if not st.alive then return end
 local p=input.Position
 if not p then return end
 local x,y=tonumber(p.X) or 0,tonumber(p.Y) or 0
 local now=os.clock()
 local previous=st.lastHumanPointer
 if motion then
  local movement=(previous and (Vector2.new(x,y)-previous).Magnitude) or 0
  local delta=(input.Delta and input.Delta.Magnitude) or 0
  if movement<2.5 and delta<2.5 then return end
 end
 -- Always keep track of the last real client pointer location.
 -- Do not learn the synthetic injection position as a human location.
 if syntheticAt(x,y,now) then return end
 st.lastHumanPointer=Vector2.new(x,y)
 if not st.on or not st.manualEnabled then return end
 st.lastManualActivity=now
 enterManualPause()
end
table.insert(connections,UIS.InputChanged:Connect(function(input)
 local kind=input.UserInputType
 if kind==Enum.UserInputType.MouseMovement or kind==Enum.UserInputType.Touch then
  recordHumanActivity(input,true)
 end
end))
-- Mouse clicks and touch-downs cover LDPlayer setups which don't deliver
-- continuous MouseMovement. Synthetic farm clicks are filtered above.
table.insert(connections,UIS.InputBegan:Connect(function(input)
 local kind=input.UserInputType
 if kind==Enum.UserInputType.MouseButton1 or kind==Enum.UserInputType.MouseButton2
    or kind==Enum.UserInputType.Touch then
  recordHumanActivity(input,false)
 end
end))
task.spawn(function()
 while st.alive do
  if st.manualPaused and st.manualEnabled and st.on then
   if os.clock()-st.lastManualActivity>=st.manualIdleSeconds then
    resumeManualPause('เมาส์นิ่งแล้ว • กลับมาฟาร์มอัตโนมัติ')
   end
  end
  task.wait(.1)
 end
end)
 -- ============================================================================
 -- V7.9.4 FLOW ENGINE / adaptive gains; optional 150/180 lab with guard.
 -- Only the existing farm coroutine calls turboTick; no parallel tapping.
 local STANDARD_SEQUENCE={3,4,5,6,7,7,6,5,4,3}
 local LAB_SEQUENCE={3,4,5,6,7,8,9,9,8,7,6,5,4,3}
 local turbo={cursor=1,scores={},samples={},clickScores={},phaseAt=0,
              measureAt=0,startSize=nil,nextAt=0,lockedAt=0,
              lockedScore=0,checkAt=0,checkSize=nil,lowChecks=0,
              seq=STANDARD_SEQUENCE,actualPeak120=0}
 local function turboRate(index)
  index=math.clamp(math.floor(tonumber(index) or 7),1,#rates)
  if index>7 and not st.speedLabEnabled then index=7 end
  if st.rate~=index then st.rate=index;updateButtons() end
 end
 local function turboReset(reason,delay,restoreStable)
  turbo.cursor=1;turbo.scores={};turbo.samples={};turbo.clickScores={}
  turbo.seq=(st.speedLabEnabled and os.clock()>=st.speedLabCooldownUntil)
    and LAB_SEQUENCE or STANDARD_SEQUENCE
  turbo.actualPeak120=0
  turbo.phaseAt=0;turbo.measureAt=0;turbo.startSize=nil
  turbo.nextAt=os.clock()+(tonumber(delay) or 8)
  turbo.lockedAt=0;turbo.lockedScore=0;turbo.checkAt=0
  turbo.checkSize=nil;turbo.lowChecks=0
  st.turboGainRate=0;st.turboBestGain=0;st.turboBestRate=120;st.turboTrials=0
  st.turboPhase=st.turboEnabled and 'WAIT' or 'OFF'
  st.turboMessage=st.turboEnabled and (reason or 'เตรียมทดสอบ') or 'MANUAL • กำหนดความเร็วเอง'
  if restoreStable and st.turboEnabled then turboRate(7) end
  flowInvalidate()
 end
 local function turboSuspend(reason,delay)
  if not st.turboEnabled or st.turboPhase=='OFF' then return end
  if st.turboPhase=='WAIT' or st.turboPhase=='LOCKED_WAIT' then return end
  local wasLocked=st.turboPhase=='LOCKED'
  st.turboPhase=wasLocked and 'LOCKED_WAIT' or 'WAIT'
  turbo.measureAt=0;turbo.startSize=nil
  turbo.nextAt=os.clock()+(tonumber(delay) or 8)
  st.turboMessage=reason or 'พักการวัดชั่วคราว'
  if not wasLocked then turboRate(turbo.seq[turbo.cursor] or 7) end
  flowInvalidate()
 end
 local function turboBegin(now)
  turbo.cursor=1;turbo.scores={};turbo.samples={};turbo.clickScores={}
  st.turboPhase='SETTLE';turbo.phaseAt=now;turbo.startSize=nil
  turboRate(turbo.seq[1])
  st.turboMessage='ทดสอบ 1/'..#turbo.seq..' • '..rates[st.rate]..' คลิก/วิ'
 end
 -- A fail-safe that never has to inject extra input. A failed lab returns to
 -- 120 CPS and disables laboratory exploration for the current session.
 local function labFallback(reason)
  st.speedLabEnabled=false
  st.speedLabCooldownUntil=os.clock()+900
  st.flowGuardHits=0
  turboReset(reason or 'Speed Lab ไม่คุ้ม • กลับ 120',15,false)
  turboRate(7)
  st.turboBestRate=120
  st.turboPhase='LOCKED';turbo.lockedAt=os.clock()
  turbo.lockedScore=0;turbo.checkAt=os.clock();turbo.checkSize=nil
  st.turboMessage=(reason or 'Speed Lab ไม่คุ้ม')..' • กลับ 120'
 end
 local function turboFinalScore(now)
  local baseCount=turbo.samples[3] or 0
  local baseline=baseCount>0 and (turbo.scores[3]/baseCount) or 0
  local bestIndex,bestScore=3,baseline
  -- Require TWO valid windows at each speed, and >=10% improvement over 55.
  if baseCount>=2 and baseline>0 then
   for index=4,7 do
    local count=turbo.samples[index] or 0
    if count>=2 then
     local score=turbo.scores[index]/count
     if score>bestScore*1.10 then bestIndex,bestScore=index,score end
    end
   end
  end
  if baseCount<2 or baseline<=0 then bestIndex=7;bestScore=0 end
  local at120=(turbo.samples[7] or 0)>=2 and
    (turbo.scores[7]/turbo.samples[7]) or 0
  local clicks120=(turbo.samples[7] or 0)>=2 and
    ((turbo.clickScores[7] or 0)/turbo.samples[7]) or 0
  -- 150/180 only win when BOTH growth AND measured input rate improve vs 120.
  if st.speedLabEnabled and at120>0 and clicks120>0 and
     now>=st.speedLabCooldownUntil then
   for index=8,9 do
    local count=turbo.samples[index] or 0
    if count>=2 then
     local gain=turbo.scores[index]/count
     local delivered=(turbo.clickScores[index] or 0)/count
     if gain>=at120*1.15 and delivered>=clicks120*1.06 and
        gain>=bestScore*1.10 then
      bestIndex,bestScore=index,gain
     end
    end
   end
  end
  turboRate(bestIndex)
  st.turboBestRate=rates[bestIndex]
  st.turboBestGain=bestScore
  st.turboPhase='LOCKED'
  st.turboMessage='FLOW • เลือก '..rates[bestIndex]..' คลิก/วิ จากการโตจริง'
  turbo.lockedAt=now;turbo.lockedScore=bestScore
  turbo.checkAt=now;turbo.checkSize=nil;turbo.lowChecks=0
  st.flowGuardHits=0
 end
 local function turboTick(now,p,cap)
  if not st.turboEnabled or not st.on or not st.eat then return end
  if type(p)~='number' or type(cap)~='number' or cap<=0 then return end
  if st.manualPaused or st.resetPending or st.mapBusy or p>=cap*.94 or st.stalls>0 then
   turboSuspend('พักการวัด • รอช่วงฟาร์มต่อเนื่อง',10)
   return
  end
  if st.turboPhase=='OFF' then turboReset('เริ่ม Adaptive Turbo',6,true) end
  if st.turboPhase=='WAIT' then
   if now>=turbo.nextAt then
    if turbo.cursor>1 and turbo.cursor<=#turbo.seq then
     st.turboPhase='SETTLE';turbo.phaseAt=now
     turboRate(turbo.seq[turbo.cursor])
     st.turboMessage='ทดสอบต่อ '..turbo.cursor..'/'..#turbo.seq..' • '..rates[st.rate]
    else turboBegin(now) end
   end
   return
  end
  if st.turboPhase=='LOCKED_WAIT' then
   if now>=turbo.nextAt then
    st.turboPhase='LOCKED';turbo.checkSize=nil;turbo.checkAt=now
    st.turboMessage='ฟาร์มต่อด้วย '..st.turboBestRate..' คลิก/วิ'
   end
   return
  end
  if st.turboPhase=='SETTLE' then
   if now-turbo.phaseAt>=st.turboSettleSeconds then
    turbo.measureAt=now;turbo.startSize=p;st.turboPhase='MEASURE'
   end
   return
  end
  if st.turboPhase=='MEASURE' then
   if p<turbo.startSize then
    turboSuspend('ขนาดเปลี่ยน/รีเซ็ต • วัดช่วงเดิมใหม่',10)
    return
   end
   local elapsed=now-turbo.measureAt
   if elapsed<st.turboWindowSeconds then return end
   local index=turbo.seq[turbo.cursor]
   local gain=math.max(0,(p-turbo.startSize)/math.max(1,elapsed))
   st.turboGainRate=gain;st.turboTrials=st.turboTrials+1
   turbo.scores[index]=(turbo.scores[index] or 0)+gain
   turbo.samples[index]=(turbo.samples[index] or 0)+1
   turbo.clickScores[index]=(turbo.clickScores[index] or 0)+(st.actualRate or 0)
   turbo.cursor=turbo.cursor+1
   if turbo.cursor>#turbo.seq then
    turboFinalScore(now)
   else
    turboRate(turbo.seq[turbo.cursor])
    turbo.phaseAt=now;st.turboPhase='SETTLE'
    st.turboMessage='ทดสอบ '..turbo.cursor..'/'..#turbo.seq..' • '..rates[st.rate]
   end
   return
  end
  if st.turboPhase=='LOCKED' then
   if turbo.checkSize==nil then turbo.checkSize=p;turbo.checkAt=now;return end
   if p<turbo.checkSize then
    turboSuspend('ขนาดลดลง • รอหลังรีเซ็ต',10)
    return
   end
   if now-turbo.checkAt>=20 then
    local gain=math.max(0,(p-turbo.checkSize)/math.max(1,now-turbo.checkAt))
    st.turboGainRate=gain
    turbo.checkAt=now;turbo.checkSize=p
    if turbo.lockedScore>0 and gain<turbo.lockedScore*.55 then
     turbo.lowChecks=turbo.lowChecks+1
    else turbo.lowChecks=0 end
    if turbo.lowChecks>=2 then
     if st.rate>=8 then labFallback('การโตลดลงหลังเร่ง')
     else turboReset('ประสิทธิภาพลดลง • ทดสอบใหม่',15,true) end
     return
    end
   end
   if now-turbo.lockedAt>=st.turboRecheckSeconds then
    turboReset('ครบเวลา • เปรียบเทียบความเร็วใหม่',10,true)
   end
  end
 end
 -- Input throughput guard: never penalize ordinary 120 CPS. Only lab rates.
 local function flowGuardTick()
  if st.rate==7 and (st.actualRate or 0)>0 then
   st.flowBest120Actual=math.max(st.flowBest120Actual,st.actualRate)
   st.flowGuardHits=0
  elseif st.rate>=8 and st.speedLabEnabled and (st.actualRate or 0)>0 and
    st.flowBest120Actual>0 then
   if st.actualRate<st.flowBest120Actual*.80 then
    st.flowGuardHits=st.flowGuardHits+1
   else st.flowGuardHits=0 end
   if st.flowGuardHits>=3 then labFallback('คลิกจริงช้ากว่า 120') end
  else st.flowGuardHits=0 end
 end
 -- Smooth cadence: one click per iteration. No burst catch-up or busy-wait.
 local function flowPace(clickStarted,generation)
  if st.manualPaused or not st.on or st.generation~=generation then
   flowInvalidate();return
  end
  local current=os.clock()
  local interval=1/math.max(1,rates[st.rate])
  local anchor=st.flowNextClickAt or clickStarted
  if anchor<current-interval then anchor=current-interval end
  local target=anchor+interval
  st.flowNextClickAt=target
  local remaining=target-current
  if remaining>0 then task.wait(remaining) end
 end
 -- ============================================================================
local function formatNum(n)
 if not n then return "?" end
 local s=tostring(math.floor(n));local result=s:reverse():gsub("(%d%d%d)","%1,"):reverse()
 return result:gsub("^,","")
end
-- Update max capacity without changing Lua after a character upgrade.
local function refreshCapMode()
 if st.manualCap then
  capacityMode.Text="โหมด: กำหนดเอง • "..formatNum(st.manualCap)
  capacityMode.TextColor3=c.gold
 else
  capacityMode.Text="โหมด: อ่านขนาดเต็มจากเกมอัตโนมัติ"
  capacityMode.TextColor3=c.cyan
 end
end
applyCap.Activated:Connect(function()
 local raw=(capBox.Text or ""):gsub("[%s,]","")
 local n=tonumber(raw)
 if not n or n<1 or n>1e15 or n~=math.floor(n) then
  st.noticeUntil=os.clock()+6
  setMessage("ขนาดเต็มไม่ถูกต้อง • ใช้ตัวเลขจำนวนเต็ม")
  return
 end
 st.manualCap=n
 _G.ETW_MANUAL_CAP=n
 persistCapacity(n)
 capBox.Text=formatNum(n)
 refreshCapMode()
 st.noticeUntil=os.clock()+6
 setMessage("บันทึกขนาดเต็ม "..formatNum(n).." แล้ว")
end)
autoCap.Activated:Connect(function()
 st.manualCap=nil
 _G.ETW_MANUAL_CAP=nil
 persistCapacity(nil)
 capBox.Text=""
 refreshCapMode()
 st.noticeUntil=os.clock()+6
 setMessage("ใช้ขนาดเต็มตามที่เกมแสดงแล้ว")
end)
refreshCapMode()

local function elapsed(t)
 local x=math.floor(math.max(0,t));return string.format("%02d:%02d",math.floor(x/60),x%60)
end

-- The sell/reset is confirmed ONLY after ProgressText is observed at zero.
-- Auto Eat is paused throughout this function (the farm loop is single-threaded).
local function waitForZero(seconds)
 local generation=st.generation
 local untilAt=os.clock()+seconds
 local zeros=0
 while st.on and st.alive and st.generation==generation and os.clock()<untilAt do
  if st.manualPaused then
   local started=os.clock()
   if not waitForManualIdle() then return false end
   untilAt=untilAt+math.max(0,os.clock()-started)
   zeros=0 -- a zero may be caused by the user's own game actions
  end
  local now=progress()
  if now==0 then zeros=zeros+1 else zeros=0 end
  if zeros>=2 then return true end
  task.wait(.12)
 end
 return false
end
-- Coordinates of GuiObjects are often inset-relative; pointer injection uses screen pixels.
-- Check the original point and the GuiService inset-corrected point, never a random UI button.
local function inputPoints(o)
 if not o or not o:IsA("GuiObject") then return {} end
 local pos,size=o.AbsolutePosition,o.AbsoluteSize
 if size.X<35 or size.Y<10 then return {} end
 local x,y=pos.X+size.X*.5,pos.Y+size.Y*.5
 local points={}
 local inset=Vector2.new(0,0)
 pcall(function() inset=GuiService:GetGuiInset() end)
 local root=o:FindFirstAncestorOfClass("ScreenGui")
 if root and not root.IgnoreGuiInset and inset.Magnitude>0 then
  points[#points+1]={x+inset.X,y+inset.Y,"ปรับระยะขอบจอ"}
 end
 points[#points+1]={x,y,"ตำแหน่งตรง"}
 return points
end
local function clickSell(x,y,hold)
 -- Do NOT move the injected cursor while the player is handling the game.
 if waitForManualIdle and not waitForManualIdle() then return false end
 if markScriptPointer then markScriptPointer(x,y) end
 -- Moving the virtual mouse first improves hover/click state on some clients.
 if vim then pcall(function()vim:SendMouseMoveEvent(math.floor(x),math.floor(y),game)end) end
 return tap(x,y,hold)
end
local function sellWhenFull()
 local generation=st.generation
 setMessage("ขนาดเต็ม • กำลังคลิกแถบขาย")
 local label=path("Sell","ProgressText")
 local sell=path("Sell")
 if not label or not sell then return false,"sell_missing" end
 local objects={}
 -- Prefer the actual control enclosing ProgressText, not unrelated buttons.
 local ancestor=label
 while ancestor and ancestor~=sell.Parent do
  if ancestor:IsA("GuiButton") then objects[#objects+1]=ancestor end
  ancestor=ancestor.Parent
 end
 if #objects==0 then
  -- If the sell region is an input-aware frame, click its center.
  if sell:IsA("GuiObject") then objects[#objects+1]=sell end
 end
 if label:IsA("GuiObject") then objects[#objects+1]=label end
 local coordinates,seen={},{}
 for _,obj in ipairs(objects) do
  for _,xy in ipairs(inputPoints(obj)) do
   local key=math.floor(xy[1]/5)..":"..math.floor(xy[2]/5)
   if not seen[key] then seen[key]=true;coordinates[#coordinates+1]=xy end
  end
 end
 if #coordinates==0 then return false,"sell_missing" end
 -- Try only locations belonging to the actual Sell widget.
 for attempt=1,3 do
  for _,xy in ipairs(coordinates) do
   if not st.on or not st.alive or st.generation~=generation then return false,"stopped" end
   local x,y=xy[1],xy[2]
   local screen=workspace.CurrentCamera.ViewportSize
   if x>=0 and x<=screen.X and y>=0 and y<=screen.Y then
    setMessage("แตะแถบขาย • "..xy[3].." (รอบ "..attempt..")")
    if not clickSell(x,y,.065) then return false,"input" end
    if waitForZero(1.1) then return true,"ok" end
   end
  end
  setMessage("ยังไม่เป็น 0 • รอแล้วลองขายอีกครั้ง")
  pause(1.2)
 end
 return false,"not_zero"
end
-- The hamburger in the screenshot is the actual bottom-left in-game icon,
-- around 2.5% of viewport width and 95% of viewport height.
-- Do not use AdminButtons.ServerOptions: on this version it opens the gear.
local function actuallyVisible(o)
 local cur=o
 while cur and cur~=pg do
  if cur:IsA("ScreenGui") and not cur.Enabled then return false end
  if cur:IsA("GuiObject") and not cur.Visible then return false end
  cur=cur.Parent
 end
 return true
end
local function bottomLeftMenuPoints()
 local v=workspace.CurrentCamera.ViewportSize
 local inset=Vector2.new(0,0)
 pcall(function() inset=GuiService:GetGuiInset() end)
 local x,y=v.X*.025,v.Y*.953
 local p={}
 local used={}
 local function add(px,py,desc)
  if px<0 or px>v.X*.12 or py<v.Y*.9 or py>v.Y then return end
  local key=tostring(math.floor(px/5))..":"..tostring(math.floor(py/5))
  if not used[key] then
   used[key]=true;p[#p+1]={x=px,y=py,reason=desc}
  end
 end
 -- A point learned from an actual player tap has priority over guessed coordinates.
 if st.menuPoint and type(st.menuPoint.x)=="number" then
  add(st.menuPoint.x,st.menuPoint.y,"ตำแหน่งที่บันทึก")
 end
 -- First trust visible GUI rectangles from any ScreenGui under PlayerGui.
 -- This handles maps whose menu is under a different ScreenGui than Sell.
 local best,bestDist=nil,math.huge
 for _,o in ipairs(pg:GetDescendants()) do
  if o:IsA("GuiObject") and not o:IsDescendantOf(gui) and actuallyVisible(o) then
   local pos,size=o.AbsolutePosition,o.AbsoluteSize
   local cx,cy=pos.X+size.X*.5,pos.Y+size.Y*.5
   if size.X>=26 and size.X<=v.X*.13 and size.Y>=25 and size.Y<=v.Y*.16
     and cx>=0 and cx<=v.X*.12 and cy>=v.Y*.90 and cy<=v.Y*.99 then
    local dist=math.abs(cx-x)+math.abs(cy-y)
    if dist<bestDist then best,bestDist=o,dist end
   end
  end
 end
 if best then
  local pos,size=best.AbsolutePosition,best.AbsoluteSize
  add(pos.X+size.X*.5,pos.Y+size.Y*.5,"ตำแหน่งปุ่มจาก GUI")
 end
 -- Precise fallback for the actual bottom-left 3-bar button in the screenshot.
 add(x,y,"มุมซ้ายล่าง")
 if inset.Y>=5 then
  add(x,y+inset.Y,"ชดเชยขอบจอ +")
  add(x,y-inset.Y,"ชดเชยขอบจอ -")
 end
 return p
end
-- The real game control (observed in the menu screenshot) is named
-- ServerSettings > Frame > Skip > TextButton.  Resolve it within ANY
-- ScreenGui rather than relying on the first child named "ScreenGui".
local function serverMenu()
 local fallback=path("ServerSettings")
 -- Prefer the active menu when the game has kept an old hidden GUI instance.
 local function menuShown(root)
  if not root then return false end
  local frame=root:FindFirstChild("Frame")
  return frame and frame:IsA("GuiObject") and actuallyVisible(frame)
 end
 if menuShown(fallback) then return fallback end
 for _,obj in ipairs(pg:GetDescendants()) do
  if obj.Name=="ServerSettings" and not obj:IsDescendantOf(gui) then
   if menuShown(obj) then return obj end
   if not fallback then fallback=obj end
  end
 end
 return fallback
end
local function serverMenuOpen()
 local root=serverMenu()
 if not root then return false end
 local frame=root:FindFirstChild("Frame")
 if frame and frame:IsA("GuiObject") then return actuallyVisible(frame) end
 return false
end
local function skipButton()
 local root=serverMenu()
 if not root then return nil end
 local holder=root:FindFirstChild("Skip",true)
 if holder then
  local named=holder:FindFirstChild("TextButton",true)
  if named and named:IsA("GuiButton") and actuallyVisible(named) then return named end
  if holder:IsA("GuiButton") and actuallyVisible(holder) then return holder end
  for _,obj in ipairs(holder:GetDescendants()) do
   if obj:IsA("GuiButton") and actuallyVisible(obj) then return obj end
  end
 end
 -- Fallback: a button itself may be unnamed, or have its Thai label in a child.
 for _,obj in ipairs(root:GetDescendants()) do
  if obj:IsA("GuiButton") and actuallyVisible(obj) then
   local textValue=obj:IsA("TextButton") and obj.Text or ""
   local t=textValue:gsub("%s+",""):lower()
   if t=="skip" or t=="ข้าม" or t=="ข้ามแมพ" then return obj end
   for _,child in ipairs(obj:GetDescendants()) do
    if child:IsA("TextLabel") then
     local ct=child.Text:gsub("%s+",""):lower()
     if ct=="skip" or ct=="ข้าม" or ct=="ข้ามแมพ" then return obj end
    end
   end
  end
 end
 return nil
end
local function mapPause(sec)
 local generation=st.generation
 local endAt=os.clock()+sec
 while st.on and st.alive and st.generation==generation and os.clock()<endAt do
  if st.manualPaused then
   local began=os.clock()
   if not waitForManualIdle() then return end
   endAt=endAt+math.max(0,os.clock()-began)
  end
  task.wait(.07)
 end
end
local function awaitSkip(seconds,generation)
 local deadline=os.clock()+seconds
 while st.alive and st.on and st.generation==generation and os.clock()<deadline do
  if st.manualPaused then
   local started=os.clock()
   if not waitForManualIdle() then return nil end
   deadline=deadline+math.max(0,os.clock()-started)
  end
  local skip=skipButton()
  if skip then return skip end
  task.wait(.12)
 end
 return nil
end
-- Capture the top-center map title and remaining map time before pressing Skip.
-- A tap being accepted by VirtualInputManager DOES NOT prove that the game skipped.
local function mapSnapshot()
 local v=workspace.CurrentCamera.ViewportSize
 local result={title=nil,time=nil,top=-math.huge}
 for _,o in ipairs(pg:GetDescendants()) do
  if o:IsA("TextLabel") and not o:IsDescendantOf(gui) and actuallyVisible(o) then
   local pos,size=o.AbsolutePosition,o.AbsoluteSize
   local cx=pos.X+size.X*.5
   if cx>v.X*.27 and cx<v.X*.74 and pos.Y>=0 and pos.Y<v.Y*.18 then
    local value=(o.Text or ""):gsub("^%s+",""):gsub("%s+$","")
    local mm,ss=value:match("^(%d+):(%d%d)$")
    if mm and ss then
     local seconds=tonumber(mm)*60+tonumber(ss)
     if result.time==nil then result.time=seconds end
    elseif #value>=3 and #value<=90 and not value:match("^[%d%p%s]+$") then
     local priority=1000-pos.Y
     if priority>result.top then result.top=priority;result.title=value end
    end
   end
  end
 end
 return result
end
local function mapChanged(before)
 local now=mapSnapshot()
 if before.title and now.title and before.title~=now.title then return true end
 if before.time and now.time and now.time>before.time+20 then return true end
 return false
end
-- V3.8: NO guessed screen coordinates for Skip.  Never press the
-- broad Skip frame or the upper Pause-timer region.  Only touch the
-- real visible GuiButton from ServerSettings.Frame.Skip.TextButton.
local function exactSkipButton()
 local root=serverMenu()
 local frame=root and root:FindFirstChild("Frame")
 local holder=frame and frame:FindFirstChild("Skip")
 local btn=holder and holder:FindFirstChild("TextButton",true)
 if not btn or not btn:IsA("GuiButton") or not actuallyVisible(btn) then return nil end
 if btn.AbsoluteSize.X<35 or btn.AbsoluteSize.Y<16 then return nil end
 return btn
end
local function rectContains(o,x,y,margin)
 if not o or not o:IsA("GuiObject") then return false end
 local p,z=o.AbsolutePosition,o.AbsoluteSize
 local inset=margin or 0
 return x>=p.X+inset and x<=p.X+z.X-inset and y>=p.Y+inset and y<=p.Y+z.Y-inset
end
local function pauseTimerButton()
 local root=serverMenu()
 if not root then return nil,nil end
 -- The game displays the timer button as either red "หยุดชั่วคราว"
 -- (paused) or green "ไม่ได้หยุดชั่วคราว" (running).
 for _,o in ipairs(root:GetDescendants()) do
  if o:IsA("GuiButton") and actuallyVisible(o) then
   local txt=o:IsA("TextButton") and o.Text or ""
   if txt=="" then
    for _,child in ipairs(o:GetDescendants()) do
     if child:IsA("TextLabel") then txt=child.Text;break end
    end
   end
   txt=(txt or ""):gsub("%s+","")
   if txt=="หยุดชั่วคราว" then return o,true end
   if txt=="ไม่ได้หยุดชั่วคราว" then return o,false end
  end
 end
 return nil,nil
end
-- A strict "first GuiButton hit must equal Skip" test blocks real clicks
-- when the Skip button has decoration or sibling controls in the GUI stack.
-- Geometric guards are the safety authority; hit testing is supportive.
-- V4.0: The actual touch screen point is learned from a SUCCESSFUL manual
-- tap on the green Skip button, not inferred from GUI coordinates.  Roblox
-- GUI coordinates and injected pointer coordinates do not always coincide on
-- LDPlayer, and those guesses previously touched the Pause timer control.
-- The captured point is stored normalized to viewport size for UI scaling.
-- V4.1: LDPlayer runs the Android client. A remembered real TOUCH location
-- must be replayed as a touch before considering the mouse fallback.
-- The callback reports only "input sent", never claims a confirmed map skip.
local function touchSkipAt(x,y)
 if not vim then return false,"touch_no_virtual_input" end
 local ok=pcall(function() vim:SendTouchEvent(0,0,x,y) end)
 if not ok then return false,"touch_begin_unsupported" end
 task.wait(.09)
 local released=pcall(function() vim:SendTouchEvent(0,2,x,y) end)
 if not released then return false,"touch_release_unsupported" end
 return true,"touch_sent"
end
local function exactGuiTap(target,mode,inputMethod)
 if not target or not target:IsA("GuiButton") or not actuallyVisible(target) then
  return false,"target_missing"
 end
 if mode~="skip" then return false,"forbidden_control" end
 if exactSkipButton()~=target then return false,"wrong_skip" end
 if not st.skipPoint then return false,"not_calibrated" end
 if not serverMenuOpen() then return false,"menu_not_open" end
 local v=workspace.CurrentCamera.ViewportSize
 local x=math.floor(st.skipPoint.rx*v.X)
 local y=math.floor(st.skipPoint.ry*v.Y)
 local p,z=target.AbsolutePosition,target.AbsoluteSize
 local cx,cy=p.X+z.X*.5,p.Y+z.Y*.5
 -- Guard the exact learned button rectangle. Never invent a second position.
 if math.abs(x-cx)>z.X*.5+28 or math.abs(y-cy)>z.Y*.5+28 then
  return false,"calibration_moved"
 end
 local root=serverMenu()
 local frame=root and root:FindFirstChild("Frame")
 if not frame or not frame:IsA("GuiObject") then return false,"frame_missing" end
 local fp,fz=frame.AbsolutePosition,frame.AbsoluteSize
 if y<fp.Y+fz.Y*.54 or y>fp.Y+fz.Y+20 then
  return false,"outside_skip_zone"
 end
 local pauseButton=select(1,pauseTimerButton())
 if pauseButton and rectContains(pauseButton,x,y,-16) then
  return false,"would_hit_pause"
 end
 if inputMethod=="touch" then
  -- Some clients prohibit this internal method. Report the limitation rather
  -- than guessing additional points or hitting Pause by accident.
  return touchSkipAt(x,y)
 end
 if waitForManualIdle and not waitForManualIdle() then return false,"stopped" end
 if markScriptPointer then markScriptPointer(x,y) end
 if vim then pcall(function()vim:SendMouseMoveEvent(x,y,game)end) end
 if not tap(x,y,.085) then return false,"mouse_unavailable" end
 return true,"mouse_sent"
end
-- V4.2: The Android game did not accept an injected mouse/touch on Skip.
-- Try the actual GUI button's connected click signal, using only executor
-- APIs that are present. Never trigger the pause-timer button.
-- A successful function call does NOT prove the map changed: verify afterward.
local function pressSkipSignal(btn, signalName)
 if not btn or not btn:IsA("GuiButton") or btn~=exactSkipButton() or not serverMenuOpen() then
  return false,"skip_not_ready"
 end
 local signal
 local readable=pcall(function() signal=btn[signalName] end)
 if not readable or not signal then return false,"signal_missing" end
 if type(getconnections)=="function" then
  local ok,found=pcall(getconnections,signal)
  if ok and type(found)=="table" then
   for _,conn in ipairs(found) do
    local enabled=true
    pcall(function() enabled=conn.Enabled~=false end)
    if enabled then
     local sent=pcall(function()
      if type(conn.Fire)=="function" then
       conn:Fire()
      elseif type(conn.Function)=="function" then
       conn.Function()
      else
       error("connection_not_callable")
      end
     end)
     if sent then return true,"connection/"..signalName end
    end
   end
  end
 end
 if type(firesignal)=="function" then
  local ok=pcall(function() firesignal(signal) end)
  if ok then return true,"firesignal/"..signalName end
 end
 return false,"no_callable_signal/"..signalName
end
local function restoreTimerIfPaused(generation)
 local button,isPaused=pauseTimerButton()
 if not button or not isPaused then return true,"running_or_unavailable" end
 if not st.alive or not st.on or st.generation~=generation then return false,"stopped" end
 -- This is intentionally a ONE-TIME corrective tap on the red button,
 -- ONLY when the timer is already paused from an earlier accidental tap.
 setMessage("พบว่าเวลาถูกหยุด • กำลังคืนการนับเวลา")
 local sent,reason=exactGuiTap(button,"resume")
 if not sent then return false,"unpause_"..reason end
 local untilAt=os.clock()+2.0
 while st.alive and st.on and st.generation==generation and os.clock()<untilAt do
  local _,current=pauseTimerButton()
  if current==false then return true,"timer_resumed" end
  task.wait(.15)
 end
 return false,"timer_still_paused"
end
-- Diagnostic V4: the ONLY proven working Skip input on this LDPlayer setup.
-- GUI reports center ~ (480,320), but Roblox pointer injection requires
-- GuiService:GetGuiInset().Y (+58 in the user's verified 960x540 test).
-- Return whether SKIP's actual GUI events fired, not merely whether VIM
-- accepted the API call. Never touch the timer/pause button.
local function pressSkipWithGuiInset(generation)
 if not vim then return false,"vim_unavailable" end
 if waitForManualIdle and not waitForManualIdle() then return false,"stopped" end
 if not st.alive or not st.on or st.generation~=generation then return false,"stopped" end
 local btn=exactSkipButton()
 if not btn or not serverMenuOpen() then return false,"skip_missing" end
 local p,size=btn.AbsolutePosition,btn.AbsoluteSize
 local baseX=p.X+size.X*.5
 local baseY=p.Y+size.Y*.5
 local pauseObj=select(1,pauseTimerButton())
 if pauseObj and rectContains(pauseObj,baseX,baseY,-8) then
  return false,"pause_overlap"
 end
 local inset=Vector2.new(0,0)
 pcall(function() inset=GuiService:GetGuiInset() end)
 local x=math.floor(baseX+inset.X+.5)
 local y=math.floor(baseY+inset.Y+.5)
 local viewport=workspace.CurrentCamera.ViewportSize
 if x<0 or y<0 or x>viewport.X or y>viewport.Y+inset.Y then
  return false,"skip_outside_screen"
 end
 local clicked=false
 local activated=false
 local c1=btn.MouseButton1Click:Connect(function() clicked=true end)
 local c2=btn.Activated:Connect(function() activated=true end)
 setMessage("กด SKIP ด้วย VIM + ขอบจอ "..math.floor(inset.Y+.5).."px")
 if markScriptPointer then markScriptPointer(x,y) end
 local ok,err=pcall(function()
  vim:SendMouseButtonEvent(x,y,0,true,game,0)
  task.wait(.12) -- exactly the hold used in the successful Diagnostic V4
  vim:SendMouseButtonEvent(x,y,0,false,game,0)
 end)
 -- Allow deferred GUI signals to run before checking the result.
 task.wait(.17)
 c1:Disconnect()
 c2:Disconnect()
 if not ok then return false,"vim_error:"..tostring(err):sub(1,70) end
 if not clicked and not activated then return false,"skip_no_event" end
 return true,"skip_event_received"
end

local function waitMapChange(before,seconds,generation)
 local untilAt=os.clock()+seconds
 while st.alive and st.on and st.generation==generation and os.clock()<untilAt do
  if st.manualPaused then
   local started=os.clock()
   if not waitForManualIdle() then return false end
   untilAt=untilAt+math.max(0,os.clock()-started)
  end
  if mapChanged(before) then return true end
  task.wait(.15)
 end
 return false
end
-- Press the SAME bottom-left hamburger again after Skip.  Never use
-- the Pause-timer button to dismiss server settings.  If the toggle fails,
-- the known red Done (X) control is the only fallback.
local function closeServerSettings(openPoint,generation)
 if not serverMenuOpen() then return true,"already_closed" end
 if not st.alive or not st.on or st.generation~=generation then return false,"stopped" end
 local point=openPoint
 if not point then
  local points=bottomLeftMenuPoints()
  point=points[1]
 end
 if point then
  setMessage("ปิดเมนูเซิร์ฟเวอร์ • กด ☰ ซ้ายล่าง")
  tap(point.x,point.y,.085)
  mapPause(.45)
  if not serverMenuOpen() then return true,"hamburger" end
 end
 local root=serverMenu()
 local done=root and root:FindFirstChild("Done",true)
 if done and done:IsA("GuiButton") and actuallyVisible(done) then
  setMessage("ปุ่ม ☰ ไม่ปิด • ปิดหน้าต่างด้วย X")
  press(done)
  mapPause(.45)
  if not serverMenuOpen() then return true,"done" end
 end
 return false,"menu_close_failed"
end
local function changeMap()
 if not st.on then return false,"stopped" end
 if waitForManualIdle and not waitForManualIdle() then return false,"stopped" end
 if st.mapBusy then return false,"busy" end
 if st.resetPending then return false,"reset_lock" end
 st.mapBusy=true
 local generation=st.generation
 local openedAt=nil
 local ok,success,reason=pcall(function()
  local before=mapSnapshot()
  if not serverMenuOpen() then
   local points=bottomLeftMenuPoints()
   if #points==0 then return false,"hamburger_missing" end
   for _,xy in ipairs(points) do
    if not st.alive or not st.on or st.generation~=generation then return false,"stopped" end
    if serverMenuOpen() then break end
    setMessage("เปิดตั้งค่าเซิร์ฟเวอร์ • ☰ ซ้ายล่าง")
    if not tap(xy.x,xy.y,.085) then return false,"input" end
    local skip=awaitSkip(1.8,generation)
    if skip and serverMenuOpen() then openedAt=xy;break end
    if serverMenuOpen() then break end
   end
  end
  if not serverMenuOpen() then return false,"menu_not_open" end
  if not exactSkipButton() then return false,"skip_missing" end
  -- Never press the timer control automatically. If already paused, ask
  -- the player to unpause it manually instead of guessing a button.
  local _,timerPaused=pauseTimerButton()
  if timerPaused then return false,"timer_paused_manual" end
  -- ONE click on the real Skip TextButton using the V4 proven coordinate
  -- conversion; no signals injection, no touch fallback and no guessed points.
  local sent,why=pressSkipWithGuiInset(generation)
  if not sent then return false,why end
  setMessage("SKIP รับคลิกจริงแล้ว • ตรวจว่าแมพเปลี่ยน")
  if waitMapChange(before,5.0,generation) then return true,"confirmed" end
  -- A GUI click event is proven, but map title/timer text may not be
  -- available to verify. Do not claim the map changed in this case, and
  -- avoid repeated clicks that might skip multiple maps accidentally.
  return true,"skip_event_unverified_map"
 end)
 -- Keep the hamburger menu closing routine proven in V3.8/V3.9.
 local closed=true
 local closeReason="already_closed"
 if st.alive and st.on and st.generation==generation and serverMenuOpen() then
  closed,closeReason=closeServerSettings(openedAt,generation)
 end
 st.mapBusy=false
 if ok and success and reason=="confirmed" then
  st.mapCount=st.mapCount+1
  if type(st.onBenchmarkBoundary)=='function' then pcall(st.onBenchmarkBoundary,'MAP',os.clock()) end
 end
 if not ok then return false,"runtime: "..tostring(success):sub(1,70) end
 if not closed then return false,closeReason end
 return success,reason
end
local function mapError(reason)
 if reason=="skip_no_event" then return "VIM ส่งคลิกแล้ว แต่ SKIP ไม่รับเหตุการณ์ • ตรวจ GuiInset" end
 if reason=="vim_unavailable" then return "ไม่พบ VirtualInputManager ใน Delta" end
 if reason=="skip_outside_screen" then return "พิกัด SKIP หลังชดเชยอยู่นอกจอ" end
 if reason=="hamburger_missing" then return "ไม่พบตำแหน่งปุ่ม ☰ ซ้ายล่าง" end
 if reason=="skip_missing" then
  local root=serverMenu()
  if not root then return "ไม่พบ ServerSettings • ยังเปิดเมนูไม่สำเร็จ" end
  local holder=root:FindFirstChild("Skip",true)
  if holder then return "พบ Skip แต่ปุ่มกดยังไม่พร้อม • เช็กหน้าเมนู" end
  return "เปิด ServerSettings แล้ว • แต่ไม่พบโฟลเดอร์ Skip"
 end
 if reason=="map_not_confirmed" then return "ส่งคำสั่งปุ่ม ข้าม แล้ว แต่แมพไม่เปลี่ยน • ยังไม่ยืนยันสำเร็จ" end
 if reason=="skip_signal_unsupported" then return "Delta ไม่มีวิธีกดเหตุการณ์ Skip ที่รองรับ • ใช้ตำแหน่งที่จำไว้แทน" end
 if reason=="skip_not_calibrated" then return "ยังไม่ได้จำปุ่มข้าม • เปิดเมนู > ◎ จำข้าม > แตะปุ่มเขียว 1 ครั้ง" end
 if reason=="skip_calibration_moved" then return "ตำแหน่งปุ่มข้ามเปลี่ยน • กรุณาจับจุดข้ามใหม่" end
 if reason=="timer_paused_manual" then return "เวลาถูกหยุดอยู่ • กรุณาเปิดเวลาเดิน 1 ครั้งก่อนทดสอบแมพ" end
 if reason=="timer_still_paused" then return "ปลดหยุดเวลาไม่สำเร็จ • ยังไม่ข้ามแมพ" end
 if tostring(reason):match("^unpause_") then return "หยุดเวลายังเปิด • ไม่คลิกสุ่ม ("..reason..")" end
 if tostring(reason):match("^skip_") or reason=="pause_overlap" then return "ป้องกันกดผิดปุ่ม • "..tostring(reason) end
 if reason=="menu_not_open" then return "ยังเปิดเมนูตั้งค่าเซิร์ฟเวอร์ไม่ได้" end
 if reason=="menu_close_failed" then return "ลองปิดหน้าเซิร์ฟเวอร์แล้ว • ยังเปิดอยู่ กรุณาตรวจเมนู" end
 if reason=="reset_lock" then return "กำลังรีเซ็ต • ยังเปลี่ยนแมพไม่ได้" end
 if reason=="input" then return "ส่งคำสั่งคลิกไม่ได้" end
 if reason=="stopped" then return "ระบบถูกสั่งหยุด" end
 return "เปลี่ยนแมพไม่ได้ : "..tostring(reason)
end
-- Optional coordinate inspection, with no auto click.
-- Calibrating a manual point is no longer necessary after Diagnostic V4.
calibrateSkip.Activated:Connect(function()
 local btn=exactSkipButton()
 if not btn or not serverMenuOpen() then
  st.noticeUntil=os.clock()+9
  setMessage("เปิดเมนูเซิร์ฟเวอร์ก่อนเพื่อตรวจจุด SKIP")
  return
 end
 local p,z=btn.AbsolutePosition,btn.AbsoluteSize
 local inset=Vector2.new(0,0)
 pcall(function() inset=GuiService:GetGuiInset() end)
 local x=math.floor(p.X+z.X*.5+inset.X+.5)
 local y=math.floor(p.Y+z.Y*.5+inset.Y+.5)
 st.noticeUntil=os.clock()+14
 setMessage("SKIP VIM="..x..","..y.." (ขอบจอ +"..math.floor(inset.Y+.5)..")")
end)

-- One-time location learning. Click "จับจุดเมนู", then manually tap the real bottom-left
-- hamburger once. No map change is triggered during learning.
calibrate.Activated:Connect(function()
 st.calibrating=true
 st.noticeUntil=os.clock()+10
 setMessage("แตะ ☰ ซ้ายล่างด้วยตัวเอง 1 ครั้ง")
 task.delay(10,function()
  if st.alive and st.calibrating then
   st.calibrating=false
   st.noticeUntil=os.clock()+8
   setMessage("หมดเวลาจับจุด • กดปุ่มจับจุดอีกครั้ง")
  end
 end)
end)
table.insert(connections,UIS.InputBegan:Connect(function(input)
 if not st.calibrating then return end
 local kind=input.UserInputType
 if kind~=Enum.UserInputType.MouseButton1 and kind~=Enum.UserInputType.Touch then return end
 local p=input.Position;local v=workspace.CurrentCamera.ViewportSize
 if p.X>v.X*.20 or p.Y<v.Y*.82 then return end
 st.calibrating=false
 st.menuPoint={x=p.X,y=p.Y}
 _G.ETW_MENU_POINT=st.menuPoint
 st.noticeUntil=os.clock()+10
 setMessage("จำพิกัด ☰ แล้ว • กดทดสอบแมพอีกครั้ง")
 task.delay(1.0,function()
  if not st.alive then return end
  if skipButton() then
   st.noticeUntil=os.clock()+12
   setMessage("เปิดหน้า SKIP ได้แล้ว • กดทดสอบแมพ")
  end
 end)
end))
manualMap.Activated:Connect(function()
 if not st.alive or st.mapBusy then return end
 if not st.on then setMessage("กด HOME หรือปุ่มเริ่มฟาร์มก่อนทดสอบแมพ");return end
 task.spawn(function()
  local good,reason=changeMap()
  if good then
   st.manualRefreshAt=os.clock();st.stalls=0
   st.noticeUntil=os.clock()+10
   setMessage(reason=="confirmed" and "ตรวจพบแมพเปลี่ยนแล้ว • กลับไปฟาร์ม"
    or "SKIP รับคลิกแล้ว • ยังตรวจชื่อแมพใหม่ไม่ได้")
  else
   st.noticeUntil=os.clock()+12
   setMessage(mapError(reason))
  end
 end)
end)

-- V4.6: sample progress every 5 seconds. Two consecutive stagnant windows
-- (10 seconds minimum) before map switching. Grace periods prevent false
-- stalls during map loading/reset; 20s cooldown prevents rapid re-skips.
local function farm(generation)
 local ok,err=pcall(function()
  local cycleStart=os.clock()
  local nextUi=0
  local missingSince=nil
  local probeAt=os.clock()+st.stallProbeSeconds
  local probeP=nil
  local probeScore=nil
  local graceUntil=os.clock()+st.stallGraceSeconds
  local rateAt=os.clock()
  local rateClicks=0
  st.flowNextClickAt=nil
  st.stalls=0;st.actualRate=0
  while st.on and st.alive and st.generation==generation do
   if st.manualPaused then
    if not waitForManualIdle() then break end
   end
   if st.manualJustResumed then
    -- Human interaction must not be counted as stalled farming or stale data.
    local resumedAt=os.clock()
    st.manualJustResumed=false
    st.stalls=0
    missingSince=nil
    probeP=progress();probeScore=cubes()
    probeAt=resumedAt+st.stallProbeSeconds
    graceUntil=resumedAt+st.stallGraceSeconds
    rateAt=resumedAt;rateClicks=0
    st.actualRate=0;nextUi=0
    flowInvalidate()
    if st.turboEnabled then turboSuspend('ผู้ใช้ควบคุมเมาส์ • รอฟาร์มต่อ',8) end
   end
   if st.mapBusy or serverMenuOpen() then
    if st.turboEnabled and st.turboPhase~='WAIT' then
     turboSuspend('เมนูแมพเปิด • รอฟาร์มต่อ',10)
    end
    if not st.mapBusy and os.clock()>=st.noticeUntil then
     setMessage("เมนูเซิร์ฟเวอร์เปิด • พักการกิน")
    end
    -- Menu open time must not count as stagnant gameplay.
    probeAt=os.clock()+st.stallProbeSeconds;graceUntil=os.clock()+st.stallGraceSeconds
    task.wait(.10)
   else
    local now=os.clock()
    if st.manualRefreshAt then
     if st.turboEnabled then turboReset('เปลี่ยนแมพ • เริ่มวัดใหม่',10,true) end
     st.manualRefreshAt=nil;st.stalls=0
     flowInvalidate()
     probeP=progress();probeScore=cubes()
     probeAt=now+st.stallProbeSeconds;graceUntil=now+st.stallGraceSeconds
     rateAt=now;rateClicks=0
    end
    local p,cap,score=flowRead(now)
    trackProgress(p,score)
    if p==nil or cap==nil or cap<=0 then
     if st.turboEnabled and st.turboPhase~='WAIT' then
       turboSuspend('รอข้อมูลขนาดจากเกม',10)
      end
     missingSince=missingSince or now
     -- Bounded Seamless Recovery: no clicks while missing; allow brief UI reload.
     -- Still stop after 25s, rather than looping forever on a broken screen.
     if now-missingSince>25 then
      setMessage("อ่านข้อมูลเกมไม่เจอ 25 วิ • หยุดเพื่อความปลอดภัย")
      break
     end
     if now-missingSince>9 then
      setMessage("FLOW RECOVERY • รอข้อมูลเกมกลับมา")
     end
     probeAt=now+st.stallProbeSeconds;graceUntil=now+st.stallGraceSeconds
     setMessage("กำลังรอข้อมูลเกมกลับมา")
     pause(.4)
    else
     if missingSince then
      st.flowRecovered=st.flowRecovered+1
      flowInvalidate()
      probeAt=now+st.stallProbeSeconds;graceUntil=now+st.stallGraceSeconds
      probeP=p;probeScore=score
      rateAt=now;rateClicks=0
     end
     missingSince=nil
     if now-rateAt>=2 then
      st.actualRate=math.floor(rateClicks/math.max(.001,now-rateAt)+.5)
      rateClicks=0;rateAt=now
      flowGuardTick()
      -- V8.1.17.4: passive benchmark observation; failure cannot stop Farm.
      if type(st.onBenchmarkTick)=='function' then pcall(st.onBenchmarkTick,now) end
     end
     if now>=nextUi then
      updateMetrics(p,cap,score,elapsed(now-cycleStart))
      nextUi=now+.3
     end
     if p>=cap then st.resetPending=true end
     if st.turboEnabled then
      if not st.eat and st.turboPhase~='WAIT' then
       turboSuspend('ปิดการกินอัตโนมัติ • พัก Turbo',10)
      elseif st.eat then
       turboTick(now,p,cap)
      end
     end
     if st.resetPending then
      -- NEVER eat or attempt a map change until confirmed zero twice.
      probeAt=now+st.stallProbeSeconds;probeP=p;probeScore=score;st.stalls=0
      if p==0 then
       if waitForZero(.65) then
        st.resetPending=false;st.resetTries=0
        st.resetCount=st.resetCount+1
        if type(st.onBenchmarkBoundary)=='function' then pcall(st.onBenchmarkBoundary,'RESET',os.clock()) end
        flowInvalidate()
        graceUntil=os.clock()+st.stallGraceSeconds
        probeAt=os.clock()+st.stallProbeSeconds;probeP=0;probeScore=cubes()
        setMessage("รีเซ็ตสำเร็จ • กลับไปกินต่อ")
       else
        setMessage("กำลังยืนยันศูนย์ • หยุดกินไว้")
        pause(.4)
       end
      elseif not st.reset then
       setMessage("ขนาดเต็ม • กรุณาเปิดรีเซ็ตอัตโนมัติ")
       pause(.8)
      else
       st.resetTries=st.resetTries+1
       local sold,reason=sellWhenFull()
       if sold then
        st.resetPending=false;st.resetTries=0;st.stalls=0
        st.resetCount=st.resetCount+1
        if type(st.onBenchmarkBoundary)=='function' then pcall(st.onBenchmarkBoundary,'RESET',os.clock()) end
        flowInvalidate()
        graceUntil=os.clock()+st.stallGraceSeconds;probeAt=os.clock()+st.stallProbeSeconds
        probeP=0;probeScore=cubes()
        setMessage("รีเซ็ตเป็น 0 แล้ว • เริ่มกินใหม่")
       elseif reason=="input" then
        setMessage("รีเซ็ตไม่ได้ • อินพุตล้มเหลว");break
       elseif reason=="stopped" then
        break
       else
        setMessage("รีเซ็ตยังไม่เป็น 0 • ลองอีก ("..st.resetTries..")")
        pause(st.resetTries%6==0 and 15 or 5)
       end
      end
     else
      if probeP==nil then
       probeP=p;probeScore=score;probeAt=now+st.stallProbeSeconds
      end
      if now>=probeAt then
       local moved=(probeP~=nil and p>probeP) or
        (probeScore~=nil and score~=nil and score>probeScore)
       if now<graceUntil then
        st.stalls=0
       elseif moved then
        st.stalls=0
       elseif st.eat then
        st.stalls=math.min(2,st.stalls+1)
       else
        st.stalls=0
       end
       probeP=p;probeScore=score;probeAt=now+st.stallProbeSeconds
       if st.eat and st.stalls==1 then
        st.noticeUntil=now+2
        setMessage("ขนาดและแต้มไม่เพิ่ม 5 วิ / กำลังตรวจซ้ำ")
       end
      end
      if st.eat and st.stalls>=2 and st.map and now-st.lastMapAttempt>=st.mapAttemptCooldown then
       st.stalls=0
       st.lastMapAttempt=now
       local changed,reason=changeMap()
       if st.turboEnabled then turboReset('เปลี่ยนแมพ/พยายามข้าม • วัดใหม่',12,true) end
       local resumedAt=os.clock()
       flowInvalidate()
       graceUntil=resumedAt+st.stallGraceSeconds
       probeAt=resumedAt+st.stallProbeSeconds
       probeP=progress();probeScore=cubes()
       if changed then
        cycleStart=resumedAt
        st.noticeUntil=resumedAt+8
        setMessage(reason=="confirmed" and "เปลี่ยนแมพแล้ว • กลับไปกิน"
         or "SKIP รับคลิก • ตรวจแมพใหม่ต่อ")
        pause(reason=="confirmed" and .65 or 1.2)
       else
        st.noticeUntil=resumedAt+8
        setMessage(mapError(reason))
        pause(3)
       end
      elseif st.eat then
       if st.map and st.stalls>=2 and now-st.lastMapAttempt<st.mapAttemptCooldown then
        st.stalls=0
        probeP=p;probeScore=score;probeAt=now+st.stallProbeSeconds
        st.noticeUntil=now+3
        setMessage("รอช่วงตรวจแมพถัดไป / ป้องกันการเปลี่ยนรัว")
       end
       setMessage("กำลังกินดิน")
       local screen=workspace.CurrentCamera.ViewportSize
       local begin=os.clock()
       if not tap(screen.X*.5,screen.Y*.5,.004) then
        setMessage("ส่งคลิกกินดินไม่ได้ • หยุด")
        break
       end
       st.clickCount=st.clickCount+1
       rateClicks=rateClicks+1
       flowPace(begin,generation)
      else
       setMessage("ฟาร์มเปิดอยู่ • ปิดการกินดิน")
       task.wait(.16)
      end
     end
    end
   end
  end
 end)
 if st.generation~=generation then return end
 if not ok and st.alive then setMessage("ข้อผิดพลาด: "..tostring(err):sub(1,65)) end
 pauseRunTimer()
 st.on=false
 if st.alive then updateButtons() end
end
-- HOME toggles the selected features; END always stops every task.
-- LDPlayer/Android may swallow physical keys: the large in-panel toggle stays available.
local lastAnyToggle=-math.huge
local function stopAll(emergencyStop)
 if not st.alive then return end
 st.generation=st.generation+1
 pauseRunTimer()
 st.on=false;st.mapBusy=false
 st.manualPaused=false;st.manualJustResumed=false
 flowInvalidate()
 if st.turboEnabled then turboReset('หยุดแล้ว • รอ START',8,true) end
 updateButtons()
 st.noticeUntil=os.clock()+5
 setMessage(emergencyStop and "หยุดฉุกเฉินแล้ว • ทุกระบบหยุด" or "หยุดทุกระบบแล้ว")
end
local function toggleAll()
 if not st.alive then return end
 local now=os.clock()
 if now-lastAnyToggle<.34 then return end
 lastAnyToggle=now
 if st.on then stopAll(false);return end
 st.generation=st.generation+1
 st.on=true;st.stalls=0;st.actualRate=0
 flowInvalidate()
 st.activeStart=os.clock()
 st.lastTrackedSize=progress();st.lastTrackedCubes=cubes()
 if st.turboEnabled then turboReset('กำลังเริ่มฟาร์ม • เก็บข้อมูลก่อน',8,true) end
 updateButtons()
 setMessage("เริ่มฟาร์ม • เปิดระบบที่เลือกไว้")
 task.spawn(farm,st.generation)
end
start.Activated:Connect(toggleAll)
floating.Activated:Connect(toggleAll)
emergency.Activated:Connect(function()stopAll(true)end)
local lastHome=-math.huge
local lastEnd=-math.huge
local function hardwareHome()
 if not st.alive or UIS:GetFocusedTextBox() then return end
 local now=os.clock()
 if now-lastHome<.45 then return end
 lastHome=now
 toggleAll()
end
local function hardwareEnd()
 if not st.alive or UIS:GetFocusedTextBox() then return end
 local now=os.clock()
 if now-lastEnd<.45 then return end
 lastEnd=now
 stopAll(true)
end
pcall(function()
 CAS:BindActionAtPriority("ETW_HUB_HOME",function(_,phase)
  if phase==Enum.UserInputState.Begin then hardwareHome() end
  return Enum.ContextActionResult.Sink
 end,false,3000,Enum.KeyCode.Home)
 CAS:BindActionAtPriority("ETW_HUB_END",function(_,phase)
  if phase==Enum.UserInputState.Begin then hardwareEnd() end
  return Enum.ContextActionResult.Sink
 end,false,3000,Enum.KeyCode.End)
end)
table.insert(connections,UIS.InputBegan:Connect(function(input,_processed)
 if input.KeyCode==Enum.KeyCode.Home then hardwareHome()
 elseif input.KeyCode==Enum.KeyCode.End then hardwareEnd() end
end))
print("NKMPJ HUB v5.2 CINEMATIC CORE / V5.1 unchanged farm engine / VIM Inset Skip / 5s x 2")
-- END OF SCRIPT | NKMPJ HUB V5.4


-- Stable adapter for the separate V6 visual layer. Farm engine remains unchanged.
st.control={
 toggle=toggleAll,
 stop=stopAll,
 getSize=progress,
 getCapacity=capacity,
 getCubes=cubes,
 getMessage=function() return message.Text end,
 rates=rates,
 setRateIndex=function(index)
  -- Any explicit speed/preset selection wins over the automatic optimizer.
  st.turboEnabled=false;st.speedLabEnabled=false
  st.turboPhase='OFF'
  st.turboMessage='MANUAL • เลือกความเร็วเอง'
  st.rate=math.clamp(math.floor(tonumber(index) or st.rate),1,7)
  flowInvalidate()
  updateButtons()
 end,
 setTurboEnabled=function(enabled)
  st.turboEnabled=not not enabled
  if not st.turboEnabled then st.speedLabEnabled=false end
  if st.turboEnabled then
   turboReset('Adaptive Turbo ON • รอข้อมูลจริง',8,true)
  else
   turboReset('Turbo OFF',0,false)
   turboRate(7) -- Turbo OFF: return to proven live-tested 120 CPS
  end
  return st.turboEnabled
 end,
 setSpeedLabEnabled=function(enabled)
  st.speedLabEnabled=not not enabled
  st.flowGuardHits=0
  st.flowBest120Actual=0
  if st.speedLabEnabled then
   st.speedLabCooldownUntil=0
   st.turboEnabled=true
   turboReset('Speed Lab ON • วัด 55–180 โดยสมัครใจ',8,true)
  elseif st.turboEnabled then
   turboReset('Speed Lab OFF • กลับสู่ Turbo ปกติ',8,true)
  else turboRate(7) end
  return st.speedLabEnabled
 end,
 setCap=function(value)
  local n=tonumber(value)
  if not n or n<1 or n>1e15 or n~=math.floor(n) then return false end
  st.manualCap=n
  _G.ETW_MANUAL_CAP=n
  persistCapacity(n)
  capBox.Text=formatNum(n)
  refreshCapMode()
  updateMetrics(progress(),capacity(),cubes())
  setMessage("บันทึกขนาดสูงสุดแล้ว")
  return true
 end,
 autoCap=function()
  st.manualCap=nil
  _G.ETW_MANUAL_CAP=nil
  persistCapacity(nil)
  capBox.Text=""
  refreshCapMode()
  updateMetrics(progress(),capacity(),cubes())
  setMessage("อ่านขนาดสูงสุดจากเกม")
 end,
 setEffects=function(enabled)
  st.fx=not not enabled
  _G.NKMPJ_HUB_FX=st.fx
  -- The V5.4 UI is hidden; only the visible V6 layer should animate.
 end,
  setManualEnabled=function(enabled)
   st.manualEnabled=not not enabled
   if not st.manualEnabled and st.manualPaused then
    resumeManualPause('ปิดระบบพักเมื่อขยับเมาส์ • ฟาร์มต่อ')
   end
   return st.manualEnabled
  end,
 clearStats=function()
  st.gainedSize=0;st.gainedCubes=0;st.resetCount=0;st.mapCount=0
  st.lastTrackedSize=progress();st.lastTrackedCubes=cubes()
  st.noticeUntil=os.clock()+5
  updateMetrics(progress(),capacity(),cubes())
  setMessage("ล้างสถิติแล้ว")
 end,
 testMap=function()
  if not st.alive or st.mapBusy then return false end
  if not st.on then setMessage("เริ่มระบบก่อนทดสอบแมพ");return false end
  task.spawn(function()
   local good,reason=changeMap()
   if good then
    st.manualRefreshAt=os.clock();st.stalls=0
    st.noticeUntil=os.clock()+10
    setMessage(reason=="confirmed" and "เปลี่ยนแมพสำเร็จ" or "กด SKIP แล้ว • กำลังตรวจแมพ")
   else
    st.noticeUntil=os.clock()+12
    setMessage(mapError(reason))
   end
  end)
  return true
 end
}
-- Keep the old tested control widgets alive but hidden; the V6 dock is the only visible UI.
gui.Enabled=false
pcall(function()pulse:Cancel();ledFlow:Cancel();logoPulse:Cancel()end)
return st

end
local core=bootStableFarmEngine()
-- V8.1.17.4: compatibility metadata belongs to the UI, never the farm loop.
-- V7.9.4 farm decisions/click pacing unchanged; V8.1.17.4 adds protected observation hooks only.
core.lastActiveRate=0
core.microStutters=0;core.stutterQuietUntil=0
core.healthSamples={};core.healthLatestKB=0;core.healthPeakKB=0
core.healthLastAt=0;core.healthLastGoodAt=os.clock();core.healthStaleSeconds=0
core.perfReadAvgMs=0;core.perfUiAvgMs=0;core.perfUiCount=0;core.perfUiPeakMs=0
core.liveEventUpdates=0;core.liveFallbackUpdates=0;core.liveSourceRebinds=0
core.livePaints=0;core.liveCoalesced=0
core.mapLastDurationMs=0;core.resetLastDurationMs=0;core.pathCacheHits=0
core.mapGuardActive=false;core.mapAwaitGrowth=false
core.lastFarmError=nil
titanSession.core=core


-- Embedded single-icon PNG from the user-selected circular NKMPJ HUB logo.
local ICON_BASE64=[=[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]=]
-- Pre-rendered antialiased progress arcs, 0%-100% in one 10x11 PNG atlas.
-- This small, static asset is distinct from the user's original NKMPJ logo.
-- It replaces all 24 screen-space rectangle ticks; no new render loop.
_G.NKMPJ_RING_ATLAS_BASE64=[=[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]=]
local function decode64(data)
 local alphabet='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
 local lookup={}
 for i=1,#alphabet do lookup[alphabet:sub(i,i)]=i-1 end
 local result,acc,bits={},0,0
 for i=1,#data do
  local v=lookup[data:sub(i,i)]
  if v then
   acc=acc*64+v;bits=bits+6
   if bits>=8 then
    bits=bits-8
    result[#result+1]=string.char(math.floor(acc/2^bits)%256)
    acc=acc%2^bits
   end
  end
 end
 return table.concat(result)
end

-- ================================================================
-- NKMPJ HUB V7.4 CELESTIAL LUXE HYBRID MASTER | VISUAL LAYER (NO AUDIO)
-- Independent UI over the unchanged V7 stable engine above.
-- Gold/obsidian compact layout based on the user's own reference.
-- ================================================================
local Players=game:GetService('Players')
local UIS=game:GetService('UserInputService')
local TS=game:GetService('TweenService')
local pg=Players.LocalPlayer:WaitForChild('PlayerGui')

local function imgAsset(id)
 local n=tonumber(tostring(id or ''):match('%d+'))
 if n and n>0 then return 'rbxassetid://'..tostring(math.floor(n)) end
end
local iconUri=imgAsset(_G.NKMPJ_ICON_ASSET_ID)
if not iconUri then
 local loader=(type(getcustomasset)=='function' and getcustomasset) or
              (type(getsynasset)=='function' and getsynasset)
 if type(loader)=='function' and type(writefile)=='function' then
  local assetName='NKMPJ_CELESTIAL_LUXE_ICON.png'
  local success=pcall(function()writefile(assetName,decode64(ICON_BASE64))end)
  if success then
   local ok,uri=pcall(loader,assetName)
   if ok and type(uri)=='string' and #uri>0 then iconUri=uri end
  end
 end
end
ICON_BASE64=nil
_G.NKMPJ_RING_ATLAS_URI=nil -- never reuse a stale V8.1.17.4 cached ring.
-- Match the logo's proven local-asset API; if unavailable use a simple outline.
do
 local loader=(type(getcustomasset)=='function' and getcustomasset) or
              (type(getsynasset)=='function' and getsynasset)
 if type(loader)=='function' and type(writefile)=='function' then
  local file='NKMPJ_SMOOTH_RING_ATLAS_V8174_CLEAR_TRACK.png'
  local ok=pcall(function()writefile(file,decode64(_G.NKMPJ_RING_ATLAS_BASE64))end)
  if ok then
   local loaded,asset=pcall(loader,file)
   if loaded and type(asset)=='string' and #asset>0 then _G.NKMPJ_RING_ATLAS_URI=asset end
  end
 end
end
_G.NKMPJ_RING_ATLAS_BASE64=nil
local oldui=_G.NKMPJ_V71_UI
if oldui and oldui.destroy then pcall(oldui.destroy) end
oldui=_G.NKMPJ_V7_UI
if oldui and oldui.destroy then pcall(oldui.destroy) end
for _,name in ipairs({'NKMPJ_HUB_V70','NKMPJ_HUB_V71','NKMPJ_HUB_V72','NKMPJ_HUB_V73','NKMPJ_HUB_V74','NKMPJ_HUB_V75','NKMPJ_HUB_V76','NKMPJ_HUB_V761','NKMPJ_HUB_V762','NKMPJ_HUB_V763','NKMPJ_HUB_V764','NKMPJ_HUB_V765','NKMPJ_HUB_V77','NKMPJ_HUB_V78','NKMPJ_HUB_V80'}) do
 local old=pg:FindFirstChild(name)
 if old then old:Destroy() end
end
local state={alive=true,mode='full',page=1,
 theme=math.clamp(tonumber(_G.NKMPJ_V71_THEME) or 1,1,3),
 fx=math.clamp(tonumber(_G.NKMPJ_V71_FX) or 2,0,3),
 surface=math.clamp(tonumber(_G.NKMPJ_V72_SURFACE) or 2,1,3),
 motion=math.clamp(tonumber(_G.NKMPJ_V72_MOTION) or 2,1,3),
 windowSize=1} -- COMPACT LOCK (legacy STANDARD is intentionally ignored)
_G.NKMPJ_V72_SIZE=1 -- always start with Compact, even if a prior build saved Standard
_G.NKMPJ_V71_UI=state
local C={
 black=Color3.fromRGB(15,17,14),panel=Color3.fromRGB(25,25,19),
 raised=Color3.fromRGB(43,40,29),card=Color3.fromRGB(46,41,29),
 pearl=Color3.fromRGB(255,250,235),ink=Color3.fromRGB(22,20,14),
 muted=Color3.fromRGB(192,186,170),edge=Color3.fromRGB(114,98,66),
 gold=Color3.fromRGB(245,207,133),gold2=Color3.fromRGB(171,122,49),
 cyan=Color3.fromRGB(80,208,225),mint=Color3.fromRGB(101,209,184),
 rose=Color3.fromRGB(125,66,75),deep=Color3.fromRGB(8,12,11)
}
local palettes={
 {title='ROYAL CHAMPAGNE',a=Color3.fromRGB(245,207,133),b=Color3.fromRGB(170,119,47),sub=Color3.fromRGB(255,239,204)},
 {title='CYBER AURORA',a=Color3.fromRGB(86,221,243),b=Color3.fromRGB(37,110,168),sub=Color3.fromRGB(221,247,255)},
 {title='NOVA AMETHYST',a=Color3.fromRGB(199,164,255),b=Color3.fromRGB(110,65,168),sub=Color3.fromRGB(244,229,255)}
}
local function make(class,parent,p)
 local o=Instance.new(class)
 for k,v in pairs(p or {}) do o[k]=v end
 o.Parent=parent
 return o
end
local RADII={outer=18,section=14,card=12,control=10}
local function standardRadius(r)
 if not r or r<=0 then return r end
 if r>=19 then return RADII.outer end
 if r>=15 then return RADII.section end
 if r>=11 then return RADII.card end
 if r>=7 then return RADII.control end
 return r
end
local function frame(parent,x,y,w,h,bg,rad,alpha)
 local f=make('Frame',parent,{Position=UDim2.fromOffset(x,y),Size=UDim2.fromOffset(w,h),
  BackgroundColor3=bg or C.panel,BackgroundTransparency=alpha or 0,BorderSizePixel=0})
 if rad and rad>0 then make('UICorner',f,{CornerRadius=UDim.new(0,standardRadius(rad))}) end
 return f
end
local function edge(parent,col,tr,th)
 return make('UIStroke',parent,{Color=col or C.edge,Transparency=tr or 0,Thickness=(th and th>1.2) and 1.25 or 1})
end
local function grad(parent,a,b,rotation)
 return make('UIGradient',parent,{Color=ColorSequence.new(a,b),Rotation=rotation or 90})
end
local function setFont(o,bold)
 pcall(function()
  o.FontFace=Font.new('rbxasset://fonts/families/BuilderSans.json',bold and Enum.FontWeight.Bold or Enum.FontWeight.Regular,Enum.FontStyle.Normal)
 end)
end
local function text(parent,s,x,y,w,h,sz,bold,col,align)
 local o=make('TextLabel',parent,{Position=UDim2.fromOffset(x,y),Size=UDim2.fromOffset(w,h),
  BackgroundTransparency=1,Text=tostring(s),TextSize=sz or 12,
  Font=bold and Enum.Font.GothamBold or Enum.Font.Gotham,
  TextColor3=col or C.pearl,TextXAlignment=align or Enum.TextXAlignment.Left,
  TextYAlignment=Enum.TextYAlignment.Center,
  TextTruncate=Enum.TextTruncate.AtEnd,TextWrapped=false})
 setFont(o,bold)
 return o
end
local function button(parent,s,x,y,w,h,bg,fg,rad)
 local o=make('TextButton',parent,{Position=UDim2.fromOffset(x,y),Size=UDim2.fromOffset(w,h),
  Text=tostring(s),TextSize=13,Font=Enum.Font.GothamBold,TextColor3=fg or C.pearl,
  BackgroundColor3=bg or C.raised,AutoButtonColor=true,BorderSizePixel=0})
 make('UICorner',o,{CornerRadius=UDim.new(0,standardRadius(rad or 10))})
 setFont(o,true)
 return o
end
-- Satin bevels, restrained highlights, and tactile button feedback.
local function jewelButton(o,accent)
 o.AutoButtonColor=false
 local stroke=edge(o,accent or C.edge,.82,1) -- soft one-pixel trim; no upper highlight stripe
 local scaler=make('UIScale',o,{Scale=1})
 o.MouseEnter:Connect(function()
  if state.alive then TS:Create(stroke,TweenInfo.new(.18),{Transparency=.47}):Play() end
 end)
 o.MouseLeave:Connect(function()
  if state.alive then TS:Create(stroke,TweenInfo.new(.22),{Transparency=.82}):Play() end
 end)
 o.Activated:Connect(function()
  if not state.alive then return end
  local t=TS:Create(scaler,TweenInfo.new(.09,Enum.EasingStyle.Quad),{Scale=.972})
  t:Play()
  t.Completed:Once(function()
   if state.alive then TS:Create(scaler,TweenInfo.new(.18,Enum.EasingStyle.Back),{Scale=1}):Play() end
  end)
 end)
 return stroke
end
local function perfectCircle(o)
 local c=o:FindFirstChildOfClass('UICorner')
 if c then c.CornerRadius=UDim.new(1,0)
 else make('UICorner',o,{CornerRadius=UDim.new(1,0)}) end
end
local function fmt(v)
 -- tostring(large_number) may use scientific notation on some Lua runtimes.
 -- Fixed-point decimal formatting is necessary before inserting separators.
 v=tonumber(v)
 if not v or v~=v or v==math.huge or v==-math.huge then return '0' end
 local sign=v<0 and '-' or ''
 local raw=string.format('%.0f',math.floor(math.abs(v)))
 local grouped=raw:reverse():gsub('(%d%d%d)','%1,'):reverse():gsub('^,','')
 return sign..grouped
end
local function short(v)
 v=tonumber(v) or 0
 if v>=1e9 then return string.format('%.2fB',v/1e9) end
 if v>=1e6 then return string.format('%.2fM',v/1e6) end
 if v>=10000 then return string.format('%.1fK',v/1000) end
 return fmt(v)
end
local function clock(n)
 n=math.max(0,math.floor(tonumber(n) or 0))
 return string.format('%02d:%02d:%02d',math.floor(n/3600),math.floor(n/60)%60,n%60)
end
local function animate(o,props,sec)
 local t=TS:Create(o,TweenInfo.new(sec or .22,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),props)
 t:Play();return t
end
local function viewport()
 local cam=workspace.CurrentCamera
 return cam and cam.ViewportSize or Vector2.new(960,540)
end
local W,H=390,394
local v=viewport()
local scale=math.clamp(math.min((v.X-14)/W,(v.Y-16)/H),.7,1)
local x=math.max(8,math.floor(v.X-W*scale-22))
local y=math.max(8,math.floor(math.min(47,(v.Y-H*scale)*.34)))
local gui=make('ScreenGui',pg,{Name='NKMPJ_HUB_V78',ResetOnSpawn=false,
 IgnoreGuiInset=true,DisplayOrder=10001,ZIndexBehavior=Enum.ZIndexBehavior.Sibling})
local shell=frame(gui,x,y,W,H,C.black,21)
local shellScale=make('UIScale',shell,{Scale=scale})
local shellStroke=edge(shell,C.edge,.60,1) -- one restrained outer outline
grad(shell,Color3.fromRGB(45,38,23),Color3.fromRGB(12,15,13),90)
shell.ClipsDescendants=true
local inner=frame(shell,2,2,W-4,H-4,C.panel,18)
grad(inner,Color3.fromRGB(35,32,24),Color3.fromRGB(17,19,16),98)
-- A single outer outline is enough; no secondary inset outline.
-- Floating highlights restrained to the header and main card.
-- HYBRID MASTER: one coherent Luxe Plate instead of four nested frames.
-- 42px circular emblem integrated into the same 54px-high header strip.
local header=frame(shell,6,5,W-12,54,Color3.fromRGB(27,27,24),14)
grad(header,Color3.fromRGB(59,46,38),Color3.fromRGB(19,25,28),12)
header.ClipsDescendants=true
local headerSweep=frame(header,-52,-9,25,75,C.gold,0,.97)
headerSweep.Rotation=17;headerSweep.Active=false
local topGlint=frame(header,9,1,W-29,1,C.gold,0,1)
topGlint.Visible=false -- remove redundant header hairline
-- V8.1.1 | ORIGINAL ART ONLY. Increase pixels on screen; never regenerate or crop icon.
-- The original 384x384 PNG and icon asset URI are unchanged.
local logoSeat=frame(header,8,3,48,48,C.deep,24)
perfectCircle(logoSeat)
local logoStroke=edge(logoSeat,C.gold,.30,1)
local logoImage=make('ImageLabel',logoSeat,{Position=UDim2.fromOffset(0,0),
 Size=UDim2.fromOffset(48,48),Image=iconUri or '',BackgroundTransparency=1,
 ScaleType=Enum.ScaleType.Fit})
if not iconUri then text(logoSeat,'N',0,0,48,48,28,true,C.gold,Enum.TextXAlignment.Center) end
-- Animate one outline only, rather than overpainting multiple nested rings.
local haloGradient=make('UIGradient',logoStroke,{Color=ColorSequence.new({
 ColorSequenceKeypoint.new(0,C.gold),ColorSequenceKeypoint.new(.4,C.cyan),
 ColorSequenceKeypoint.new(.7,C.pearl),ColorSequenceKeypoint.new(1,C.gold)}),Rotation=0})
local title=text(header,'NKMPJ HUB ✨',67,6,203,27,18,true,C.pearl)
title.TextTruncate=Enum.TextTruncate.AtEnd
local subtitle=text(header,'ENGINE ISOLATED  /  V8.1.17.4',68,31,199,14,10,true,C.gold)
local titleRail=frame(header,63,46,88,1,C.gold,0,1)
titleRail.Visible=false -- subtitle spacing replaces the rail
-- Controls share the same baseline, hit-box, radius and visual weight.
local miniButton=button(header,'−',274,13,29,29,Color3.fromRGB(35,38,35),C.pearl,10)
local quickButton=button(header,'▤',307,13,29,29,Color3.fromRGB(42,38,29),C.gold,10)
local closeButton=button(header,'×',340,13,29,29,Color3.fromRGB(77,46,49),C.pearl,10)
miniButton.TextSize=19;quickButton.TextSize=17;closeButton.TextSize=19
-- Exactly one hairline divider below the single continuous header.
local headerLine=frame(shell,17,60,W-34,1,C.gold,0,1)
headerLine.Visible=false -- no decorative full-width line
local gleam=frame(headerLine,-48,0,42,1,C.pearl,0,1)
gleam.Visible=false
-- Status strip: visible regardless of page selection.
local statusArea=frame(shell,14,67,W-28,23,C.black,10)
-- Status chip deliberately has no added perimeter stroke.
local aura=frame(statusArea,5,4,15,15,C.mint,8,1)
local auraStroke=edge(aura,C.gold,.8,1)
local dot=frame(statusArea,9,8,7,7,C.mint,4)
local statusLabel=text(statusArea,'ระบบพร้อมทำงาน',24,2,237,19,11,true,C.pearl)
local timeLabel=text(statusArea,'00:00:00',263,2,91,19,11,true,C.gold,Enum.TextXAlignment.Right)
-- Four short compact navigation tabs; stable text bounds on Android fonts.
local nav=frame(shell,13,100,W-26,37,Color3.fromRGB(17,19,15),12)
-- Flat navigation: no outline, selected tab uses a filled background
local tabs={}
local tabNames={'🏠 หน้าแรก','📊 สถิติ','⚙️ ระบบ','🎨 ธีม'}
for i=1,4 do
 local b=button(nav,tabNames[i],5+(i-1)*89,4,87,29,
  i==1 and Color3.fromRGB(73,60,37) or Color3.fromRGB(18,20,17),
  i==1 and C.pearl or C.muted,9)
 b.TextSize=11;b.TextTruncate=Enum.TextTruncate.AtEnd;tabs[i]=b
end
local tabAccent=frame(nav,12,32,74,2,C.gold,1,1)
tabAccent.Visible=false -- no moving underline/stripes
-- Pages use the same content budget; settings pages scroll, so the window never grows.
local pages={}
for i=1,4 do
 local scrolling=i>=2 -- Stats, System and Appearance have compact scrollable content
 pages[i]=make(scrolling and 'ScrollingFrame' or 'Frame',shell,{
  Position=UDim2.fromOffset(13,145),Size=UDim2.fromOffset(W-26,195),
  BackgroundTransparency=1,BorderSizePixel=0,Visible=i==1
 })
 if scrolling then
  pages[i].CanvasSize=UDim2.fromOffset(W-26,460)
  pages[i].ScrollBarThickness=3
  pages[i].ScrollBarImageColor3=C.gold
  pages[i].ScrollingDirection=Enum.ScrollingDirection.Y
 end
end
-- HOME / decorative royal gemstone is independent from actual logo.
local home=pages[1]
local hero=frame(home,1,0,362,101,Color3.fromRGB(52,43,27),15)
hero.ClipsDescendants=true
edge(hero,C.edge,.78,1)
grad(hero,Color3.fromRGB(61,51,36),Color3.fromRGB(26,30,29),12)
local reflection=frame(hero,260,-30,29,180,C.pearl,0,1);reflection.Rotation=28
reflection.Visible=false -- remove diagonal decorative streak
local eyebrow=text(hero,'⚡ ขนาดตัวละคร  /  LIVE SIZE',12,8,261,17,11,true,C.gold)
local percent=text(hero,'0%',283,7,64,20,13,true,C.gold,Enum.TextXAlignment.Right)
local number=text(hero,'0',12,29,258,31,28,true,C.pearl)
local capHint=text(hero,'เป้าหมาย  —',12,64,257,15,10,false,C.muted)
-- Circular Celestial Reactor: cool-metal socket, real round concentric geometry, gold core.
-- Deliberately NOT another NKMPJ logo. No rotating orange square.
local gemOuter=frame(hero,299,35,45,45,Color3.fromRGB(18,28,29),23)
perfectCircle(gemOuter)
local gemOutline=edge(gemOuter,C.gold,.80,1)
grad(gemOuter,Color3.fromRGB(63,67,55),Color3.fromRGB(17,22,22),105)
local gemOrbit=frame(gemOuter,4,4,37,37,C.deep,19,1)
perfectCircle(gemOrbit)
local orbitStroke=edge(gemOrbit,C.cyan,.92,1)
local orbitGradient=make('UIGradient',orbitStroke,{Color=ColorSequence.new({
 ColorSequenceKeypoint.new(0,C.gold),ColorSequenceKeypoint.new(.32,C.cyan),
 ColorSequenceKeypoint.new(.72,C.gold2),ColorSequenceKeypoint.new(1,C.pearl)}),Rotation=0})
local gemInner=frame(gemOuter,8,8,29,29,Color3.fromRGB(78,56,25),15)
perfectCircle(gemInner)
grad(gemInner,Color3.fromRGB(230,186,103),Color3.fromRGB(74,49,24),116)
edge(gemInner,C.gold,.84,1)
-- Draw a clean vector sparkle; unsupported font glyphs can show as a square.
local sparkV=frame(gemInner,14,7,1,15,C.pearl,1,.22)
local sparkH=frame(gemInner,7,14,15,1,C.pearl,1,.22)
local sparkCenter=frame(gemInner,12,12,5,5,C.pearl,3,.12)
perfectCircle(sparkCenter)
local gemGlint=frame(gemOuter,33,7,3,3,C.pearl,2,.58)
local gemAccent=frame(gemOuter,7,33,2,2,C.cyan,1,.65)
local progressBg=frame(hero,12,91,338,6,Color3.fromRGB(30,33,30),4)
local progressFill=frame(progressBg,0,0,1,6,C.gold,4)
progressFill.ClipsDescendants=true
local progressShine=frame(progressFill,-18,-1,18,10,C.pearl,2,.62)
progressShine.Rotation=8
local progressGradient=grad(progressFill,Color3.fromRGB(255,248,208),C.gold2,0)
-- Three compact capsules; important information fits without an empty gap.
local function statBox(x,heading)
 local f=frame(home,x,108,115,38,Color3.fromRGB(36,39,35),11)
 -- Borderless stat capsule; use background contrast for grouping
 text(f,heading,9,5,101,12,9,false,C.muted)
 return text(f,'0',9,19,101,16,15,true,C.pearl)
end
local gainLabel=statBox(1,'📈 ขนาดที่เพิ่ม')
local resetLabel=statBox(125,'🔄 รีเซ็ต')
local mapLabel=statBox(249,'🗺️ เปลี่ยนแมพ')
-- Compact quick shortcuts. The same core flags are used by the System switches;
-- no duplicate automation tasks, no new polling loop.
state.homeButtons={}
do
 local function homeSwitch(key,x,label)
  local b=button(home,label,x,153,115,34,C.raised,C.pearl,10)
  b.TextSize=11;b.TextTruncate=Enum.TextTruncate.AtEnd
  -- One-color status chips without decorative perimeters
  state.homeButtons[key]=b
 end
 homeSwitch('reset',1,'🔄 รีเซ็ต')
 homeSwitch('map',125,'🗺️ แมพ')
 homeSwitch('manual',249,'🖱 เมาส์')
end
local liveNote=text(home,'ตรวจค้าง 0/2',2,181,359,14,10,false,C.muted)
-- STATS / four summary cards with zero duplicate rows.
local stats=pages[2]
-- Information belongs to STATS, not the primary Home viewport.
liveNote.Parent=stats
liveNote.Position=UDim2.fromOffset(6,205)
liveNote.Size=UDim2.fromOffset(352,18)
local function statCard(x,y,heading)
 local f=frame(stats,x,y,176,58,Color3.fromRGB(36,36,28),12)
 grad(f,Color3.fromRGB(57,46,32),Color3.fromRGB(29,34,34),16)
 -- Subtle background gradient, no marker line or ring
 text(f,heading,10,12,156,16,11,false,C.muted)
 return text(f,'0',10,30,156,23,19,true,C.pearl)
end
local statsSize=statCard(1,0,'📈 ขนาดเพิ่มทั้งหมด')
local statsCubes=statCard(187,0,'🧊 แต้มที่เพิ่ม')
local statsTime=statCard(1,65,'⏱️ เวลาฟาร์มจริง')
local statsCount=statCard(187,65,'🔄 รีเซ็ต / แมพ')
local rateText=text(stats,'⚡ คลิกจริง: 0 ครั้ง/วิ',8,135,348,21,12,true,C.gold)
local chartBg=frame(stats,1,163,362,31,Color3.fromRGB(28,31,25),9)
local rateBars={}
for i=1,16 do
 rateBars[i]=frame(chartBg,12+(i-1)*21,22,12,4,i%4==0 and C.gold2 or C.gold,2,.14)
end
-- CORE / all actual engine controls, including capacity and map test.
local settings=pages[3]
local function settingsSection(y,labelText)
 text(settings,labelText,6,y,330,20,12,true,C.gold)
end
settingsSection(0,'⚙️  การทำงานอัตโนมัติ')
local toggles={}
local function toggleRow(y,heading,key)
 local f=frame(settings,2,y,356,45,Color3.fromRGB(34,34,28),10)
 grad(f,Color3.fromRGB(51,44,33),Color3.fromRGB(27,34,33),12)
 edge(f,C.edge,.88,1)
 local headingLabel=text(f,heading,12,6,225,32,12,true,C.pearl)
 headingLabel.TextTruncate=Enum.TextTruncate.AtEnd
 local b=button(f,'ON',270,8,74,29,C.raised,C.pearl,13)
 toggles[key]=b
 return b
end
toggleRow(26,'🌱 กินอัตโนมัติ','eat')
toggleRow(340,'🔄 รีเซ็ตเมื่อเต็ม','reset')
toggleRow(391,'🗺️ เปลี่ยนแมพเมื่อค้าง','map')
settingsSection(78,'⚡  ความเร็วและ Turbo')
local rateBox=frame(settings,2,104,356,45,C.raised,10)
local slower=button(rateBox,'−',8,7,40,31,C.panel,C.pearl,8)
local rateLabel=text(rateBox,'85 ครั้ง/วินาที',59,9,237,28,15,true,C.gold,Enum.TextXAlignment.Center)
local faster=button(rateBox,'+',308,7,40,31,C.panel,C.pearl,8)
settingsSection(527,'🎯  ขนาดเป้าหมาย')
local entry=make('TextBox',settings,{Position=UDim2.fromOffset(3,553),Size=UDim2.fromOffset(220,35),
 BackgroundColor3=C.raised,Text='',PlaceholderText='เช่น 7,469,100',TextSize=13,
 Font=Enum.Font.Gotham,TextColor3=C.pearl,PlaceholderColor3=C.muted,
 ClearTextOnFocus=false,BorderSizePixel=0})
make('UICorner',entry,{CornerRadius=UDim.new(0,10)});setFont(entry,false)
local save=button(settings,'💾 บันทึก',231,553,128,35,C.gold,C.ink,10)
local autoCap=button(settings,'🔍 อ่านขนาดสูงสุดจากเกม',3,596,356,32,C.raised,C.pearl,10)
local testMap=button(settings,'🗺️ ทดลองเปลี่ยนแมพ',3,641,356,35,C.raised,C.gold,10)
local clearStats=button(stats,'🧹 ล้างสถิติในเซสชัน',3,412,355,34,C.raised,C.pearl,10)
text(settings,'▶ ปุ่มทอง: เริ่ม/หยุดฟาร์ม   |   ⛔ ปุ่มแดง: หยุดเท่านั้น',6,731,353,20,10,false,C.muted)
text(settings,'× ปิด HUB ทั้งหมด   •   Auto Reset/Map รอยืนยันผลก่อนสั่งซ้ำ',6,753,353,20,10,false,C.muted)
-- V7.9.2 Manual Override: one lightweight switch in the existing System tab.
local manualRow=toggleRow(442,'🖱️ พักเมื่อขยับเมาส์','manual')
text(settings,'พัก Farm / Reset / Map • นิ่ง 3 วิ = ทำงานต่อ',7,490,350,22,10,false,C.muted)
-- Adaptive Turbo owns speed selection only; Mouse Override remains independent.
local turboRow=toggleRow(160,'🚀 Turbo • วัดการโตจริง','turbo')
local turboNote=text(settings,'ทดสอบ 55–120 คลิก/วิ • เลือกจากการโตจริง',7,208,350,20,10,false,C.muted)
local turboStatus=text(settings,'TURBO • รอเริ่มระบบ',7,237,350,57,11,true,C.gold)
turboStatus.TextWrapped=true
turboStatus.TextYAlignment=Enum.TextYAlignment.Top
-- V7.9.5: remove high-speed lab completely; keep the working Flow monitor.
settingsSection(315,'🛡️  Auto Reset / Map / Mouse Override')
-- Performance belongs to STATS: no duplicate heavy strings on hidden System UI.
text(stats,'🧠  FLOW ENGINE  /  PERFORMANCE',6,232,344,19,12,true,C.gold)
local flowStatus=text(frame(stats,2,254,358,143,C.raised,12),'FLOW • 120 พร้อมใช้งาน',8,8,342,130,11,true,C.gold)
-- Informational card uses background grouping without an extra frame outline
flowStatus.TextWrapped=true;flowStatus.TextYAlignment=Enum.TextYAlignment.Top
settings.CanvasSize=UDim2.fromOffset(364,794)
stats.CanvasSize=UDim2.fromOffset(364,1130)
-- LOOK / theme and motion controls, plus a live informational status.
local look=pages[4]
text(look,'🎨  เลือกธีมที่ใช่',5,0,340,20,12,true,C.gold)
local themeButtons={}
for i,name in ipairs({'👑 CHAMPAGNE','🌌 CYBER AURORA','💜 AMETHYST'}) do
 local y=26+(i-1)*51
 local f=frame(look,2,y,355,45,Color3.fromRGB(33,33,27),12)
 grad(f,Color3.fromRGB(48,43,34),Color3.fromRGB(26,31,34),17)
 edge(f,C.edge,.88,1)
 local swatch=frame(f,11,10,24,24,palettes[i].a,8)
 grad(swatch,palettes[i].a,palettes[i].b,125)
 text(f,name,46,6,173,32,12,true,C.pearl)
 themeButtons[i]=button(f,'เลือก',259,8,84,28,C.raised,C.gold,9)
end
text(look,'✨  เอฟเฟกต์แสง',5,190,341,22,12,true,C.pearl)
local fxBtns={}
for i,vv in ipairs({'OFF','SOFT','NORMAL','ELITE'}) do
 fxBtns[i]=button(look,vv,3+(i-1)*91,217,86,34,C.raised,C.pearl,9)
 fxBtns[i].TextSize=11
end
local hint=text(look,'วงแหวนโลโก้ · แสงสะท้อน · ปุ่มโลหะ · เปลี่ยนหน้า',5,258,352,25,11,false,C.muted)
local miniHelp=text(look,'ย่อแล้วเหลือโลโก้เดียว  |  ไม่มีเสียงเอฟเฟกต์',5,283,355,26,11,false,C.muted)
text(look,'🌫️  พื้นผิวหน้าต่าง',5,315,330,20,12,true,C.pearl)
local surfaceBtns={}
for i,name in ipairs({'SOLID','SATIN','GLASS'}) do
 surfaceBtns[i]=button(look,name,3+(i-1)*120,341,114,34,C.raised,C.pearl,10)
end
text(look,'🎞️  จังหวะการเคลื่อนไหว',5,389,350,19,12,true,C.pearl)
local motionBtns={}
for i,name in ipairs({'SLOW','NORMAL','SWIFT'}) do
 motionBtns[i]=button(look,name,3+(i-1)*120,415,114,34,C.raised,C.pearl,10)
end
text(look,'🔒  ขนาดหน้าต่าง (ล็อก)',5,462,350,20,12,true,C.pearl)
local sizeBtns={}
for i,name in ipairs({'🔒 COMPACT  •  DEFAULT / LOCKED'}) do
 sizeBtns[i]=button(look,name,3,488,355,34,C.raised,C.pearl,10)
 sizeBtns[i].TextSize=12
 sizeBtns[i].Active=false
 sizeBtns[i].AutoButtonColor=false
end
local styleReset=button(look,'↺  คืนค่าดีไซน์เริ่มต้น',3,541,355,35,C.raised,C.gold,10)
local lookStatus=text(look,'✨ TITAN COMPACT V8.0.2 • ไม่มีเสียง',5,592,352,23,11,true,C.gold)
look.CanvasSize=UDim2.fromOffset(364,645)
-- Bottom action row, fixed: never disappears when switching settings.
local action=frame(shell,13,345,W-26,35,C.panel,10)
local start=button(action,'▶  เริ่มฟาร์ม',0,0,230,35,C.gold,C.ink,10)
start.TextSize=13 -- primary toggle: START if stopped, STOP if running
local emergency=button(action,'⛔ หยุดทั้งหมด',240,0,124,35,Color3.fromRGB(94,55,63),C.pearl,10)
emergency.TextSize=11 -- a one-way stop; X remains the only actual UI exit
local startGrad=grad(start,C.gold,Color3.fromRGB(226,163,75),0)
-- On the signature primary button, a very transparent traveling light bar.
start.ClipsDescendants=true
local actionSheen=frame(start,-43,-20,32,80,C.pearl,0,.91)
actionSheen.Rotation=19
local chromeButtons={start,emergency,miniButton,quickButton,closeButton,save,
 autoCap,testMap,clearStats,slower,faster}
for _,b in ipairs(tabs) do chromeButtons[#chromeButtons+1]=b end
for _,b in ipairs(themeButtons) do chromeButtons[#chromeButtons+1]=b end
for _,b in ipairs(fxBtns) do chromeButtons[#chromeButtons+1]=b end
for _,b in ipairs(surfaceBtns) do chromeButtons[#chromeButtons+1]=b end
for _,b in ipairs(motionBtns) do chromeButtons[#chromeButtons+1]=b end
for _,b in ipairs(sizeBtns) do chromeButtons[#chromeButtons+1]=b end
chromeButtons[#chromeButtons+1]=styleReset
-- Navigation is flat and chip-like; do not add shiny top bars or stroke rings.
for _,b in ipairs(chromeButtons) do
 if b.Parent~=nav then jewelButton(b,b==start and C.gold or C.edge) end
end
local foot=frame(shell,14,385,W-28,1,C.edge,1,1)
foot.Visible=false
-- QUICK HUD V8.1.17.4: 216x78, larger progress ring, unchanged lightning and farm.
-- Percent is live, original logo stays in the header; no duplicate game size.
-- Farm engine and its update cadence are unchanged.
local qw,qh=216,78
local qScaleFactor=1 -- exact pixels; avoid fuzzy fractional image sampling
local qFootW,qFootH=qw*qScaleFactor,qh*qScaleFactor
local quick=frame(gui,x+W*scale-qFootW-72,y+56,qw,qh,
 Color3.fromRGB(10,14,23),15)
local quickScale=make('UIScale',quick,{Scale=qScaleFactor})
state.quickFx={};state.quickFx.neonStroke=edge(quick,Color3.fromRGB(29,216,244),.19,1.25)
state.quickFx.neonGradient=make('UIGradient',state.quickFx.neonStroke,{
 Color=ColorSequence.new({
  ColorSequenceKeypoint.new(0,Color3.fromRGB(43,226,247)),
  ColorSequenceKeypoint.new(.45,Color3.fromRGB(32,129,246)),
  ColorSequenceKeypoint.new(.75,Color3.fromRGB(117,84,240)),
  ColorSequenceKeypoint.new(1,Color3.fromRGB(43,226,247))}),Rotation=0})
state.quickFx.neonTween=TS:Create(state.quickFx.neonGradient,
 TweenInfo.new(7,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,-1,false),
 {Rotation=360})
grad(quick,Color3.fromRGB(17,23,38),Color3.fromRGB(9,12,19),90)
quick.Visible=false;quick.ClipsDescendants=true
local qHeader=frame(quick,3,2,qw-6,22,Color3.fromRGB(23,29,39),7)
local qLogo=make('ImageLabel',qHeader,{Position=UDim2.fromOffset(2,1),
 Size=UDim2.fromOffset(20,20),BackgroundTransparency=1,
 Image=iconUri or '',ScaleType=Enum.ScaleType.Fit})
if not iconUri then text(qHeader,'N',2,1,20,20,14,true,C.gold,Enum.TextXAlignment.Center) end
-- Three independent actions: full console, mini orb, and true shutdown.
local qTitle=text(qHeader,'NKMPJ 8.1.17.4 ⚡',25,1,115,20,10,true,C.pearl)
qTitle.TextTruncate=Enum.TextTruncate.AtEnd
local qFull=button(qHeader,'▣',144,2,19,18,Color3.fromRGB(34,41,48),C.gold,5)
local qMin=button(qHeader,'−',166,2,19,18,Color3.fromRGB(34,41,48),C.pearl,5)
local qExit=button(qHeader,'×',188,2,19,18,Color3.fromRGB(106,43,56),C.pearl,5)
-- Three aligned 19x18 header controls: open, minimize, true exit.
qFull.TextSize=12;qMin.TextSize=13;qExit.TextSize=15
-- Subtle shared press/hover feedback; no continuous animation and no new loop.
jewelButton(qFull,C.gold);jewelButton(qMin,C.cyan)
jewelButton(qExit,Color3.fromRGB(218,95,112))
-- V7.6.2: luminous WHITE titles with one composited, engine-driven sweep.
-- No frame-by-frame Lua loop; only the title visible in the current mode runs.
local function buildWhiteSheen(lbl,duration)
 -- The only intentional glow: the real TITLE label, without duplicated text.
 -- Android/LDPlayer: strong overlays blur glyphs; a single light stroke stays crisp.
 lbl.TextColor3=Color3.fromRGB(255,255,255)
 lbl.TextStrokeColor3=Color3.fromRGB(242,247,255)
 lbl.TextStrokeTransparency=.72
 local g=make('UIGradient',lbl,{
  Color=ColorSequence.new({
   ColorSequenceKeypoint.new(0,Color3.fromRGB(219,226,232)),
   ColorSequenceKeypoint.new(.38,Color3.fromRGB(233,240,248)),
   ColorSequenceKeypoint.new(.49,Color3.fromRGB(255,255,255)),
   ColorSequenceKeypoint.new(.56,Color3.fromRGB(255,255,255)),
   ColorSequenceKeypoint.new(.67,Color3.fromRGB(234,242,249)),
   ColorSequenceKeypoint.new(1,Color3.fromRGB(219,226,232))
  }),Rotation=0,Offset=Vector2.new(-1.15,0)
 })
 local tw=TS:Create(g,TweenInfo.new(duration,Enum.EasingStyle.Linear,
  Enum.EasingDirection.InOut,-1,false),{Offset=Vector2.new(1.15,0)})
 return g,tw
end
local fullTitleSheen,fullTitleTween=buildWhiteSheen(title,3.6)
local quickTitleSheen,quickTitleTween=buildWhiteSheen(qTitle,3.1)
local function updateTitleShimmer(mode)
 fullTitleTween:Cancel();quickTitleTween:Cancel()
 fullTitleSheen.Offset=Vector2.new(-1.15,0)
 quickTitleSheen.Offset=Vector2.new(-1.15,0)
 -- QUICK ECO: the compact title is legible without a perpetual gradient
 -- tween. Full Console retains its premium title animation when opened.
 if mode=='full' and not (state.ux and state.ux.perfPaused) then fullTitleTween:Play() end
end
-- Smooth progress ring: one antialiased sprite atlas instead of 24 blocks.
-- ImageRectOffset changes only when the percentage crosses a 1% boundary.
-- Fallback: subtle full circle + large numeric percentage if no custom asset.
local qRingBg=frame(quick,7,27,48,48,Color3.fromRGB(15,22,31),24)
qRingBg.BackgroundTransparency=1 -- clean transparent ring: no dark disc under arc
state.quickFx.ringStroke=edge(qRingBg,Color3.fromRGB(37,203,234),
 _G.NKMPJ_RING_ATLAS_URI and 1 or .65,1)
local qRingArt=make('ImageLabel',qRingBg,{
 Name='SmoothProgressArc',Position=UDim2.fromOffset(0,0),
 Size=UDim2.fromOffset(48,48),BackgroundTransparency=1,
 Image=_G.NKMPJ_RING_ATLAS_URI or '',ImageRectSize=Vector2.new(80,80),
 ImageRectOffset=Vector2.new(0,0),ImageTransparency=.02,
 ScaleType=Enum.ScaleType.Stretch})
local qRingStep=-1
local qRingIcon=text(qRingBg,'⚡',15,14,18,20,12,true,C.gold,Enum.TextXAlignment.Center)
local qPercent=text(quick,'--%',62,29,83,24,20,true,C.gold,Enum.TextXAlignment.Left)
setFont(qPercent,true)
qPercent.TextScaled=false
qPercent.TextWrapped=false
qPercent.TextTruncate=Enum.TextTruncate.AtEnd
local qHint=text(quick,'รอข้อมูลเกม',62,55,84,13,8,false,C.muted)
qHint.Visible=false -- Only show a source-error message; no repeated 'progress' row.
local qState=text(quick,'พร้อม',62,55,84,14,9,true,C.mint)
qState.TextTruncate=Enum.TextTruncate.AtEnd
-- V8.1.17.4: farm clock and primary toggle form ONE centered right-side group.
-- Clock prefix restored; no frame. Two-pixel gap; ring artwork only updated.
state.qFarmTime=text(quick,'⏱ 00:00',144,32,70,14,10,true,C.cyan,Enum.TextXAlignment.Center)
state.qFarmTime.TextScaled=true
make('UITextSizeConstraint',state.qFarmTime,{MinTextSize=8,MaxTextSize=10})
state.qFarmTime.TextTruncate=Enum.TextTruncate.AtEnd
-- Button is directly below the time: x=149, y=48, 60x21; vertical group centered.
local qToggle=button(quick,'▶ เริ่ม',149,48,60,21,C.gold,C.ink,6)
qToggle.TextSize=9
jewelButton(qToggle,C.gold)
-- This compatibility-only element stays invisible; hidden charts never repaint.
local qProgressBg=frame(quick,0,0,1,1,C.black,0)
qProgressBg.Visible=false
local qProgress=frame(qProgressBg,0,0,1,1,C.gold,0)
local qProgressTween=nil
local qProgressLastWidth=-1
local function setQuickRing(ratio,hasCap)
 local active=hasCap and math.clamp(math.floor(ratio*100+.5),0,100) or 0
 if active==qRingStep then return end
 qRingStep=active
 if _G.NKMPJ_RING_ATLAS_URI then
  qRingArt.ImageRectOffset=Vector2.new((active%10)*80,math.floor(active/10)*80)
 end
 qRingIcon.TextColor3=hasCap and C.gold or C.muted
 state.quickFx.ringStroke.Color=hasCap and C.cyan or Color3.fromRGB(53,65,77)
end
-- Only TWO native TweenService animations are allowed in Quick mode.
-- They are paused in Full/Mini and when auto-farm is not active.
state.quickFx.running=false
state.syncQuickMotion=function()
 local shouldRun=state.alive and state.mode=='quick' and core.on and
  not core.manualPaused and not (state.ux and state.ux.perfPaused) and
  (state.fx or 0)>0
 if state.quickFx.running==shouldRun then return end
 state.quickFx.running=shouldRun
 state.quickFx.neonTween:Cancel()
 if shouldRun then
  state.quickFx.ringStroke.Transparency=_G.NKMPJ_RING_ATLAS_URI and 1 or .65
  qRingArt.ImageTransparency=.02
  state.quickFx.neonTween:Play()
 else
  state.quickFx.neonGradient.Rotation=0
  state.quickFx.ringStroke.Transparency=_G.NKMPJ_RING_ATLAS_URI and 1 or .65
  qRingArt.ImageTransparency=.02
 end
end
-- Mini Orb is the actual user-selected PNG and nothing else: no panel, no shadow.
local MINI=48
local mini=make('ImageButton',gui,{Name='MiniOrbOnly_V74',
 Position=UDim2.fromOffset(x+W*scale-MINI-8,y+75),
 Size=UDim2.fromOffset(MINI,MINI),BackgroundTransparency=1,BorderSizePixel=0,
 Image=iconUri or '',ScaleType=Enum.ScaleType.Fit,AutoButtonColor=true,Visible=false})
if not iconUri then
 mini.Image=''
 local miniN=text(mini,'N',0,0,MINI,MINI,28,true,C.gold,Enum.TextXAlignment.Center)
 miniN.Active=false
end
-- Prefer smooth sampling of the SAME original asset; keep old-client fallback.
for _,originalLogo in ipairs({logoImage,qLogo,mini}) do
 pcall(function()
  if Enum.ResamplerMode and Enum.ResamplerMode.Default then
   originalLogo.ResampleMode=Enum.ResamplerMode.Default
  end
 end)
end
local uiConnections={}
local fxTracks={}
-- V8.1.0 | ULTIMATE UX MANAGER (no periodic GUI update loop).
-- One table owns notifications, settings memory, UI error fencing and work budget.
do
 local ux={saveQueued=false,toastRevision=0,lastToast='',lastToastAt=-math.huge,
  errors=0,errorLast='',errorAt=-math.huge,perfPaused=false,perfUntil=0,
  lastHealthyAt=0,uiTasks={status=false,snapshot=false},uiFlushing=false,
  lastCommand={},tests={status='รอตรวจสอบ',problems={}},dockSnap=20}
 state.ux=ux
 function ux.safe(label,fn,...)
  if not state.alive then return false end
  local ok,err=pcall(fn,...)
  if not ok then
   ux.errors=ux.errors+1
   ux.errorLast=tostring(label)..': '..tostring(err):sub(1,100)
   if os.clock()-ux.errorAt>3 then
    ux.errorAt=os.clock()
    warn('NKMPJ UI isolate: '..ux.errorLast)
    if type(state.logSmart)=='function' then pcall(state.logSmart,'UI: '..ux.errorLast) end
   end
  end
  return ok
 end
 local toastBox=frame(shell,51,307,288,27,Color3.fromRGB(54,47,34),9)
 toastBox.ZIndex=35;toastBox.Visible=false
 edge(toastBox,C.edge,.78,1)
 local toastLabel=text(toastBox,'',10,2,268,23,11,true,C.pearl)
 toastLabel.ZIndex=36;toastLabel.TextTruncate=Enum.TextTruncate.AtEnd
 function ux.notify(message,kind)
  if not state.alive then return end
  message=tostring(message or '')
  if message=='' then return end
  local now=os.clock()
  if ux.lastToast==message and now-ux.lastToastAt<1.6 then return end
  ux.lastToast=message;ux.lastToastAt=now
  ux.toastRevision=ux.toastRevision+1
  local rev=ux.toastRevision
  if state.mode=='mini' then return end
  if state.mode=='quick' then
   ux.toastQuickUntil=now+1.55
   qState.Text=message
   qState.TextColor3=kind=='warning' and C.gold or C.mint
  else
   toastLabel.Text=message
   toastLabel.TextColor3=kind=='warning' and C.gold or C.pearl
   toastBox.Visible=true
  end
  task.delay(1.6,function()
   if not state.alive or rev~=ux.toastRevision then return end
   toastBox.Visible=false
   ux.toastQuickUntil=0
   if state.mode=='quick' and type(state.paintOperationalStatus)=='function' then
    ux.safe('toast-status',state.paintOperationalStatus)
   end
  end)
 end
 -- Write UI-only preferences after the USER changes something, never while size ticks.
 -- Previous JSON backups for farm settings remain separate and compatible.
 function ux.capture()
  return {format='NKMPJ_V81_UI',version=1,
   theme=state.theme,fx=state.fx,surface=state.surface,motion=state.motion,
   page=state.page,uiMode=state.mode,windowSize=1,
   positions={full={shell.Position.X.Offset,shell.Position.Y.Offset},
    quick={quick.Position.X.Offset,quick.Position.Y.Offset},
    mini={mini.Position.X.Offset,mini.Position.Y.Offset}}}
 end
 function ux.scheduleSave()
  if not state.alive then return end
  _G.NKMPJ_V81_UI_STATE=ux.capture()
  if ux.saveQueued then return end
  ux.saveQueued=true
  task.delay(1.5,function()
   ux.saveQueued=false
   if not state.alive then return end
   local current=ux.capture()
   _G.NKMPJ_V81_UI_STATE=current
   if type(writefile)~='function' then return end
   ux.safe('prefs-save',function()
    local http=game:GetService('HttpService')
    writefile('NKMPJ_V81_UI_Prefs.json',http:JSONEncode(current))
   end)
  end)
 end
 function ux.command(name,cooldown)
  if not state.alive then return false end
  local now=os.clock()
  local last=ux.lastCommand[name] or -math.huge
  if now-last<(cooldown or 1) then
   ux.notify('⏳ กำลังรอคำสั่งก่อนหน้า','warning')
   return false
  end
  ux.lastCommand[name]=now
  return true
 end
 function ux.restore()
  local data=_G.NKMPJ_V81_UI_STATE
  if type(data)~='table' and type(readfile)=='function' then
   local ok,result=pcall(function()
    local raw=readfile('NKMPJ_V81_UI_Prefs.json')
    return game:GetService('HttpService'):JSONDecode(raw)
   end)
   if ok then data=result end
  end
  if type(data)~='table' or data.format~='NKMPJ_V81_UI' or data.version~=1 then return end
  local function choose(n,low,high,old)
   return type(n)=='number' and n==n and n>=low and n<=high and math.floor(n) or old
  end
  state.theme=choose(data.theme,1,3,state.theme)
  state.fx=choose(data.fx,0,3,state.fx)
  state.surface=choose(data.surface,1,3,state.surface)
  state.motion=choose(data.motion,1,3,state.motion)
  state.windowSize=1 -- Compact LOCK, including legacy file content.
  _G.NKMPJ_V71_THEME=state.theme;_G.NKMPJ_V71_FX=state.fx
  _G.NKMPJ_V72_SURFACE=state.surface;_G.NKMPJ_V72_MOTION=state.motion
  if type(data.positions)=='table' then
   for id,obj in pairs({full=shell,quick=quick,mini=mini}) do
    local coords=data.positions[id]
    if type(coords)=='table' and type(coords[1])=='number' and type(coords[2])=='number'
     and coords[1]==coords[1] and coords[2]==coords[2] then
     local ww=obj==shell and W*shellScale.Scale or (obj==quick and qFootW or MINI)
     local hh=obj==shell and H*shellScale.Scale or (obj==quick and qFootH or MINI)
     local view=viewport()
     local xx=math.clamp(coords[1],3,math.max(3,view.X-ww-3))
     local yy=math.clamp(coords[2],3,math.max(3,view.Y-hh-3))
     obj.Position=UDim2.fromOffset(xx,yy)
    end
   end
  end
  local target=choose(data.page,1,4,1)
  if type(ux.applyRestored)=='function' then ux.applyRestored(target,data.uiMode) end
  if type(state.logSmart)=='function' then state.logSmart('คืนค่า UI/ตำแหน่งที่บันทึกไว้') end
 end
 function ux.selfTest()
  if not state.alive or not core.alive then return end
  local issues={}
  local function check(label,condition)
   if not condition then issues[#issues+1]=label end
  end
  check('PlayerGui',gui.Parent==pg)
  check('Compact UI',state.windowSize==1 and shellScale.Scale<=1)
  check('4 TABS',#tabs==4 and #pages==4)
  check('LIVE',type(core.onLiveSize)=='function' and type(core.control.getSize)=='function')
  check('FARM',type(core.control.toggle)=='function' and type(core.control.stop)=='function')
  check('EXIT',type(state.destroy)=='function' and type(titanSession.shutdown)=='function')
  ux.tests.problems=issues
  ux.tests.status=#issues==0 and '✅ ผ่าน 6/6' or ('⚠️ ตรวจพบ '..#issues..' จุด')
  if type(state.logSmart)=='function' then state.logSmart('SELF-TEST '..ux.tests.status) end
  if #issues>0 then warn('NKMPJ self-test: '..table.concat(issues,', ')) end
 end
end

local function stopFX()
 for _,t in ipairs(fxTracks) do pcall(function() t:Cancel() end) end
 fxTracks={}
 if state.visualUltra and state.visualUltra.stopFX then state.visualUltra.stopFX() end
end
-- V7.6.1 Smooth Fix: a small, deterministic effect budget.
-- User-selected FX still controls richness; at most FOUR long-lived tweens,
-- and effects hidden behind other pages are not animated.
local function startFX()
 stopFX()
 gleam.BackgroundTransparency=1
 headerSweep.BackgroundTransparency=1
 actionSheen.BackgroundTransparency=1
 progressShine.BackgroundTransparency=1
 shellStroke.Transparency=.60
 logoStroke.Transparency=.50
 auraStroke.Transparency=.72
 gemOutline.Transparency=.80
 if state.fx==0 or state.mode~='full' or (state.ux and state.ux.perfPaused) then return end
 local level=state.fx
 local pace=({1.5,1,.78})[state.motion] or 1
 local dur=(level>=3 and 8 or (level==2 and 10 or 13))*pace
 local function repeating(o,ti,props)
  if #fxTracks>=4 then return end
  local tw=TS:Create(o,ti,props)
  fxTracks[#fxTracks+1]=tw
 end
 -- One smooth engine-driven logo pulse across ALL tabs.
 repeating(logoStroke,TweenInfo.new(dur*.65,Enum.EasingStyle.Sine,
  Enum.EasingDirection.InOut,-1,true),{Transparency=.84})
 -- No moving header divider: reserve effects budget for visible logo/progress.
 if state.page==1 and level>=2 then
  -- Keep home-page effects idle when another page is selected.
  progressShine.Position=UDim2.fromOffset(-18,-1)
  progressShine.BackgroundTransparency=.76
  repeating(progressShine,TweenInfo.new(dur*.85,Enum.EasingStyle.Linear,
   Enum.EasingDirection.InOut,-1,false),{Position=UDim2.fromOffset(350,-1)})
 end
 -- Reactor no longer spins: smaller static emblem is lighter and less distracting.
 if state.visualUltra and state.visualUltra.startFX then
  state.visualUltra.startFX(repeating,dur,level)
 end
 for _,t in ipairs(fxTracks) do t:Play() end
end
local function applyPersonalization()
 local palettesForSurface={0,.035,.12}
 inner.BackgroundTransparency=palettesForSurface[state.surface]
 hero.BackgroundTransparency=({0,.04,.11})[state.surface]
 -- Keep the Compact physical footprint; adapt down only on small viewports.
 state.windowSize=1
 shellScale.Scale=math.min(scale,.87)
 local v=viewport()
 local xx=math.clamp(shell.Position.X.Offset,3,math.max(3,v.X-W*shellScale.Scale-3))
 local yy=math.clamp(shell.Position.Y.Offset,3,math.max(3,v.Y-H*shellScale.Scale-3))
 shell.Position=UDim2.fromOffset(xx,yy)
 local function mark(btns,val)
  for i,b in ipairs(btns) do
   b.BackgroundColor3=i==val and Color3.fromRGB(92,75,46) or C.raised
   b.TextColor3=i==val and C.pearl or C.muted
  end
 end
 mark(surfaceBtns,state.surface)
 mark(motionBtns,state.motion)
 mark(sizeBtns,state.windowSize)
end
local function theme()
 local pal=palettes[state.theme]
 local prime=pal.a
 for _,obj in ipairs({headerLine,tabAccent,gleam,progressFill,qProgress,topGlint,
  gemOutline,logoStroke,auraStroke,orbitStroke,titleRail}) do
  if obj:IsA('UIStroke') then obj.Color=prime else obj.BackgroundColor3=prime end
 end
 eyebrow.TextColor3=prime;subtitle.TextColor3=prime
 percent.TextColor3=prime;qPercent.TextColor3=prime;timeLabel.TextColor3=prime
 qRingStep=-1
 qRingArt.ImageRectOffset=Vector2.new(0,0)
 qRingIcon.TextColor3=prime
 state.quickFx.neonStroke.Color=Color3.fromRGB(40,217,244)
 lookStatus.TextColor3=prime;hint.TextColor3=C.muted
 progressGradient.Color=ColorSequence.new(pal.a,pal.b)
 startGrad.Color=ColorSequence.new(pal.a,pal.b)
 qToggle.BackgroundColor3=prime
 start.BackgroundColor3=prime
 save.BackgroundColor3=prime
 rateLabel.TextColor3=prime
 for i,b in ipairs(themeButtons) do
  b.Text=i==state.theme and 'ใช้อยู่' or 'เลือก'
  b.BackgroundColor3=i==state.theme and Color3.fromRGB(92,76,47) or C.raised
 end
 if state.visualUltra and state.visualUltra.applyTheme then state.visualUltra.applyTheme() end
end
local function selectPage(i)
 state.page=i
 for j,p in ipairs(pages) do
  p.Visible=j==i
  if j==i then
   if state.fx>0 and state.mode=='full' then
    p.Position=UDim2.fromOffset(19,145)
    animate(p,{Position=UDim2.fromOffset(13,145)},.24)
   else p.Position=UDim2.fromOffset(13,145) end
  end
 end
 for j,b in ipairs(tabs) do
  b.BackgroundColor3=j==i and Color3.fromRGB(73,60,37) or Color3.fromRGB(18,20,17)
  b.TextColor3=j==i and C.pearl or C.muted
 end
 -- Filled selected-tab state replaces moving underline
 if state.visualUltra and state.visualUltra.selectPage then state.visualUltra.selectPage(i) end
 startFX() -- Selectively run only the visible page's effects.
 if state.ux then state.ux.scheduleSave() end
 if state.requestFullSnapshot then task.defer(state.requestFullSnapshot) end
end
for i,b in ipairs(tabs) do
 local n=i;b.Activated:Connect(function()selectPage(n)end)
end
local function fxSelect()
 for i,b in ipairs(fxBtns) do
  b.BackgroundColor3=(i-1)==state.fx and Color3.fromRGB(93,74,42) or C.raised
  b.TextColor3=(i-1)==state.fx and C.pearl or C.muted
 end
 startFX()
end
for i,b in ipairs(themeButtons) do
 local n=i;b.Activated:Connect(function()
  state.theme=n;_G.NKMPJ_V71_THEME=n;theme()
  if state.ux then state.ux.scheduleSave() end
 end)
end
for i,b in ipairs(fxBtns) do
 local n=i-1;b.Activated:Connect(function()
  state.fx=n;_G.NKMPJ_V71_FX=n;fxSelect()
  if state.ux then state.ux.scheduleSave() end
 end)
end
for i,b in ipairs(surfaceBtns) do
 local n=i;b.Activated:Connect(function()
  state.surface=n;_G.NKMPJ_V72_SURFACE=n;applyPersonalization()
  if state.ux then state.ux.scheduleSave() end
 end)
end
for i,b in ipairs(motionBtns) do
 local n=i;b.Activated:Connect(function()
  state.motion=n;_G.NKMPJ_V72_MOTION=n;applyPersonalization();startFX()
  if state.ux then state.ux.scheduleSave() end
 end)
end
-- Compact size is intentionally immutable: do not attach size-changing callbacks.
styleReset.Activated:Connect(function()
 state.theme=1;state.fx=2;state.surface=2;state.motion=2;state.windowSize=1
 _G.NKMPJ_V71_THEME=1;_G.NKMPJ_V71_FX=2
 _G.NKMPJ_V72_SURFACE=2;_G.NKMPJ_V72_MOTION=2;_G.NKMPJ_V72_SIZE=1
 theme();applyPersonalization();fxSelect()
 if state.ux then state.ux.scheduleSave() end
end)
local function setMode(mode)
 state.mode=mode
 shell.Visible=mode=='full'
 quick.Visible=mode=='quick'
 mini.Visible=mode=='mini'
 if mode=='full' then startFX() else stopFX() end
 updateTitleShimmer(mode)
 state.syncQuickMotion()
 if state.paintLiveFarmTime then state.paintLiveFarmTime(true) end
 if state.visualUltra and state.visualUltra.setMode then state.visualUltra.setMode(mode) end
 if state.ux then state.ux.scheduleSave() end
 if state.requestFullSnapshot then task.defer(state.requestFullSnapshot) end
 if state.requestLiveSnapshot then task.defer(state.requestLiveSnapshot) end
 end
-- Restore settings only after all local UI callbacks have been defined.
state.ux.applyRestored=function(target,oldMode)
 theme();applyPersonalization();fxSelect();selectPage(target)
 -- Restore Quick only; never boot into an invisible mini orb by accident.
 if oldMode=='quick' then setMode('quick') end
end
local function clampPos(xx,yy,ww,hh)
 local view=viewport()
 return math.clamp(xx,3,math.max(3,view.X-ww-3)),
        math.clamp(yy,3,math.max(3,view.Y-hh-3))
end
miniButton.Activated:Connect(function()
 local xx,yy=clampPos(shell.Position.X.Offset+W*shellScale.Scale-MINI-8,shell.Position.Y.Offset+74,MINI,MINI)
 mini.Position=UDim2.fromOffset(xx,yy)
 setMode('mini')
end)
quickButton.Activated:Connect(function()
 local xx,yy=clampPos(shell.Position.X.Offset+W*shellScale.Scale-qFootW-54,shell.Position.Y.Offset+55,qFootW,qFootH)
 quick.Position=UDim2.fromOffset(xx,yy)
 setMode('quick')
end)
qMin.Activated:Connect(function()
 local xx,yy=clampPos(quick.Position.X.Offset+qFootW-MINI,quick.Position.Y.Offset,MINI,MINI)
 mini.Position=UDim2.fromOffset(xx,yy);setMode('mini')
end)
qFull.Activated:Connect(function()
 local xx,yy=clampPos(quick.Position.X.Offset,quick.Position.Y.Offset,W*shellScale.Scale,H*shellScale.Scale)
 shell.Position=UDim2.fromOffset(xx,yy);setMode('full')
end)
local moved=false
mini.Activated:Connect(function()
 if moved then moved=false;return end
 local xx,yy=clampPos(mini.Position.X.Offset,mini.Position.Y.Offset,W*shellScale.Scale,H*shellScale.Scale)
 shell.Position=UDim2.fromOffset(xx,yy)
 setMode('full')
end)
local drag={on=false,who=nil,touch=nil,pos=nil,origin=nil}
local function dragHandle(handle,target)
 table.insert(uiConnections,handle.InputBegan:Connect(function(inp)
  if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then
   drag.on=true;drag.who=target;drag.touch=inp.UserInputType==Enum.UserInputType.Touch and inp or nil
   drag.pos=inp.Position;drag.origin=target.Position
  end
 end))
end
dragHandle(header,shell)
dragHandle(qHeader,quick)
dragHandle(mini,mini)
table.insert(uiConnections,UIS.InputChanged:Connect(function(inp)
 if not drag.on or not drag.who then return end
 if drag.touch then if inp~=drag.touch then return end
 elseif inp.UserInputType~=Enum.UserInputType.MouseMovement then return end
 local delta=inp.Position-drag.pos
 local target=drag.who
 local ww=target==shell and W*shellScale.Scale or target.AbsoluteSize.X
 local hh=target==shell and H*shellScale.Scale or target.AbsoluteSize.Y
 local xx,yy=clampPos(drag.origin.X.Offset+delta.X,drag.origin.Y.Offset+delta.Y,ww,hh)
 target.Position=UDim2.fromOffset(xx,yy)
 if target==mini and delta.Magnitude>6 then moved=true end
end))
table.insert(uiConnections,UIS.InputEnded:Connect(function(inp)
 if drag.on and ((drag.touch and drag.touch==inp) or
  (not drag.touch and inp.UserInputType==Enum.UserInputType.MouseButton1)) then
  local target=drag.who
  drag.on=false;drag.who=nil;drag.touch=nil
  if target==quick or target==mini then
   local ww=target==quick and qFootW or MINI
   local hh=target==quick and qFootH or MINI
   local view=viewport()
   local xx,yy=clampPos(target.Position.X.Offset,target.Position.Y.Offset,ww,hh)
   local right=math.max(3,view.X-ww-3)
   local left=3
   if math.abs(xx-left)<=20 then xx=left
   elseif math.abs(xx-right)<=20 then xx=right end
   target.Position=UDim2.fromOffset(xx,yy)
  end
  if state.ux then state.ux.scheduleSave() end
 end
end))
local lastProgress=-1
local rateHeights={}
local rateTweens={}
-- V8.1.17.4: Only the visible Quick HUD receives live size/percentage/progress.
-- Full Console takes a one-off snapshot on entry or when explicitly refreshed.
 -- Quick HUD: no added game reads, click controls, or number tween.
local function paintLiveSize(p,cap,allowFullSnapshot)
 if not state.alive or not core.alive or not gui.Parent then return end
 if state.mode~='quick' and not (state.mode=='full' and allowFullSnapshot) then return end
 p=tonumber(p)
 cap=tonumber(cap)
 -- A missing source is UNKNOWN, never present it as a genuine zero.
 if not p or p<0 then
  if state.mode=='quick' then
   if qPercent.Text~='--%' then qPercent.Text='--%' end
   if qHint.Text~='รอค่าจากเกม' then qHint.Text='รอค่าจากเกม' end
   if not qHint.Visible then qHint.Visible=true end
   if qState.Visible then qState.Visible=false end
   setQuickRing(0,false)
  end
  return
 end
 if state.mode=='full' then
  local shown=fmt(p)
  if number.Text~=shown then
   number.Text=shown
   local digits=#shown
   local fontSize=digits>=16 and 19 or (digits>=14 and 21 or (digits>=12 and 23 or (digits>=10 and 25 or 28)))
   if number.TextSize~=fontSize then number.TextSize=fontSize end
  end
 end
 if not cap or cap<=0 then
  if state.mode=='quick' then
   if qPercent.Text~='--%' then qPercent.Text='--%' end
   if qHint.Text~='รอค่าความจุ' then qHint.Text='รอค่าความจุ' end
   if not qHint.Visible then qHint.Visible=true end
   if qState.Visible then qState.Visible=false end
   setQuickRing(0,false)
  end
  return
 end
 local ratio=math.clamp(p/cap,0,1)
 local percentText=string.format('%.1f%%',ratio*100)
 if state.mode=='full' then
  local capText='เป้าหมาย  '..fmt(cap)
  if capHint.Text~=capText then capHint.Text=capText end
  if percent.Text~=percentText then percent.Text=percentText end
  local width=math.max(1,math.floor(338*ratio+.5))
  if lastProgress~=width then
   lastProgress=width
   progressFill.Size=UDim2.fromOffset(width,6)
  end
 elseif state.mode=='quick' then
  if qPercent.Text~=percentText then qPercent.Text=percentText end
  if qHint.Visible then qHint.Visible=false end
  if not qState.Visible then qState.Visible=true end
  setQuickRing(ratio,true)
 end
end
state.requestLiveSnapshot=function()
 if not state.alive or not core.alive or state.mode=='mini' then return end
 local p=core.control.getSize()
 if type(p)~='number' then p=core.lastLiveSize end
 local cap=core.control.getCapacity()
 if type(cap)~='number' or cap<=0 then cap=core.lastLiveCap end
 paintLiveSize(p,cap,true)
end
-- Single status source shared by Full Console and Quick HUD.
-- Event-driven: this is called on status changes and existing user snapshots.
state.paintOperationalStatus=function()
 if not state.alive or not core.alive or state.mode=='mini' then return end
 local label,small,color,background
 if core.manualPaused then
  label='⏸ พักเมาส์ • ผู้ใช้ควบคุม';small='⏸ พักเมาส์'
  color=C.gold;background=Color3.fromRGB(55,43,25)
 elseif core.resetPending then
  label='🔄 กำลังรีเซ็ต';small='🔄 รีเซ็ต'
  color=C.gold;background=Color3.fromRGB(52,40,22)
 elseif core.mapBusy then
  label='🗺️ กำลังเปลี่ยนแมพ';small='🗺️ เปลี่ยนแมพ'
  color=C.cyan;background=Color3.fromRGB(22,42,53)
 elseif core.menuPauseActive then
  label='⚠️ เมนูแมพเปิด • พักกิน';small='⚠️ เมนูแมพเปิด'
  color=C.gold;background=Color3.fromRGB(52,40,22)
 elseif core.mapGuardActive then
  label='⚠️ ไม่โต • Auto Map พัก';small='⚠️ กินไม่เพิ่ม'
  color=C.gold;background=Color3.fromRGB(52,40,22)
 elseif core.on then
  label='กำลังฟาร์ม';small='กำลังฟาร์ม'
  color=C.mint;background=Color3.fromRGB(20,44,39)
 elseif core.lastFarmError then
  label='⚠️ ฟาร์มหยุดเพราะข้อผิดพลาด';small='⚠️ FARM ERROR'
  color=C.gold;background=Color3.fromRGB(54,42,24)
 elseif not core.on then
  local reason=''
  pcall(function()reason=tostring(core.control.getMessage() or '')end)
  if reason:find('ไม่ได้',1,true) or reason:find('ผิดพลาด',1,true)
      or reason:find('อ่านข้อมูล',1,true) then
   label='⚠️ ฟาร์มหยุด: '..reason:sub(1,55)
   small='⚠️ '..reason:sub(1,26)
   color=C.gold;background=Color3.fromRGB(54,42,24)
  else
   label='หยุดฟาร์ม';small='หยุด'
   color=C.muted;background=C.black
  end
 else
  label='หยุดฟาร์ม';small='หยุด'
  color=C.muted;background=C.black
 end
 if state.mode=='full' then
  if statusLabel.Text~=label then statusLabel.Text=label end
  if statusLabel.TextColor3~=color then statusLabel.TextColor3=color end
  if dot.BackgroundColor3~=color then dot.BackgroundColor3=color end
  if auraStroke.Color~=color then auraStroke.Color=color end
  if statusArea.BackgroundColor3~=background then statusArea.BackgroundColor3=background end
  local primary=core.on and '■  หยุดฟาร์ม' or '▶  เริ่มฟาร์ม'
  if start.Text~=primary then start.Text=primary end
  -- Red stop button never starts automation, unlike the gold toggle.
  emergency.BackgroundColor3=core.on and Color3.fromRGB(94,55,63) or Color3.fromRGB(59,51,51)
 elseif state.mode=='quick' then
  local primary=core.on and '■ หยุด' or '▶ เริ่ม'
  if qToggle.Text~=primary then qToggle.Text=primary end
  if not (state.ux and (state.ux.toastQuickUntil or 0)>os.clock()) then
   if qState.Text~=small then qState.Text=small end
   if qState.TextColor3~=color then qState.TextColor3=color end
  end
  state.syncQuickMotion()
 end
end
-- V8.1.17.4: live accumulated farm clock for the visible Full/Quick HUD.
-- No new loop or game reads: called by the ALREADY EXISTING light UI pulse.
-- Core activeStart is nil while Mouse Override pauses, so the counter freezes.
state.farmClockLastWallSecond=-1
state.farmClockLastMode=''
state.paintLiveFarmTime=function(force)
 if not state.alive or not core.alive or state.mode=='mini' then return end
 local now=os.clock()
 local whole=math.floor(now)
 if not force and whole==state.farmClockLastWallSecond and state.mode==state.farmClockLastMode then return end
 state.farmClockLastWallSecond=whole;state.farmClockLastMode=state.mode
 local active=math.max(0,tonumber(core.activeTotal) or 0)
 if core.on and core.activeStart then
  active=active+math.max(0,now-core.activeStart)
 end
 local seconds=math.floor(active)
 if state.mode=='full' then
  local shown=clock(seconds)
  if timeLabel.Text~=shown then timeLabel.Text=shown end
  if state.page==2 and statsTime.Text~=shown then statsTime.Text=shown end
  -- The Benchmark countdown is for STATS only; paint just the timer/progress,
  -- not its graph or metrics, once per second while this tab is visible.
  local b=state.benchmark
  if state.page==2 and b and type(b.paintClock)=='function' then
   b.paintClock(now)
  end
 elseif state.mode=='quick' then
  local hh=math.floor(seconds/3600)
  local mm=math.floor(seconds/60)%60
  local ss=seconds%60
  local compact=hh>0 and string.format('%d:%02d:%02d',hh,mm,ss)
   or string.format('%02d:%02d',math.floor(seconds/60),ss)
  local shown='⏱ '..compact
  if state.qFarmTime.Text~=shown then state.qFarmTime.Text=shown end
 end
end
local function refresh()
 if not state.alive or not core.alive then return end
 -- Quick ECO: Full Console is hidden. Never compute/paint its stats, chart,
 -- toggles or perf labels while the user is viewing only the small Quick HUD.
 -- The live size/progress arrives from the event-driven core.onLiveSize.
 if state.mode=='mini' then return end
 if state.mode=='quick' then
  state.paintOperationalStatus()
  return
 end
 local p=tonumber(core.control.getSize()) or 0
 local cap=math.max(1,tonumber(core.control.getCapacity()) or 1)
 paintLiveSize(p,cap,true)
 local active=(core.activeTotal or 0)+(core.on and core.activeStart and os.clock()-core.activeStart or 0)
 state.paintOperationalStatus()
 timeLabel.Text=clock(active)
 -- Current size, capacity and progress bar are painted by paintLiveSize().
 -- The full snapshot only handles the slower dashboard statistics and chart.
 gainLabel.Text='+'..short(core.gainedSize)
 resetLabel.Text=tostring(core.resetCount or 0)
 mapLabel.Text=tostring(core.mapCount or 0)
 liveNote.Text='ตรวจทุก '..tostring(core.stallProbeSeconds or 5)..' วิ  ·  ค้าง '..tostring(core.stalls or 0)..'/2'
 statsSize.Text='+'..fmt(core.gainedSize)
 statsCubes.Text='+'..fmt(core.gainedCubes)
 statsTime.Text=clock(active)
 statsCount.Text=tostring(core.resetCount or 0)..' / '..tostring(core.mapCount or 0)
 local rate=tonumber(core.actualRate) or 0
 local shownRate=(core.manualPaused and tonumber(core.lastActiveRate)) or rate
 local rateQualifier=core.manualPaused and ' (ก่อนพัก)' or ''
 rateText.Text='⚡ คลิก '..tostring(shownRate or 0)..'/วิ'..rateQualifier..' • โต '..short(math.floor(core.turboGainRate or 0))..'/วิ'
 local rateTarget=(core.control.rates or {})[core.rate] or 85
 rateLabel.Text=tostring(rateTarget)..(core.turboEnabled and ' /วิ • AUTO' or ' ครั้ง/วินาที')
 -- V7.6: bars are drawn from rolling REAL samples by Signature Ultra.
 -- Never display repeated copies of the current rate as a fake history.
 if state.visualUltra and state.visualUltra.refresh
     and os.clock()>=(core.stutterQuietUntil or 0) then
  state.visualUltra.refresh(p,cap,rate,active)
 end
 -- HOME quick toggles share the same System flags, not separate state.
 for k,b in pairs(state.homeButtons) do
  local enabled=(k=='reset' and core.reset) or (k=='map' and core.map) or
    (k=='manual' and core.manualEnabled) or false
  local title=(k=='reset' and '🔄 รีเซ็ต') or (k=='map' and '🗺️ แมพ') or '🖱 เมาส์'
  b.Text=title..(enabled and '  ON' or '  OFF')
  b.BackgroundColor3=enabled and Color3.fromRGB(29,72,64) or Color3.fromRGB(46,45,41)
  b.TextColor3=enabled and C.pearl or C.muted
 end
 for _,pair in ipairs({{toggles.eat,core.eat},{toggles.reset,core.reset},{toggles.map,core.map},{toggles.manual,core.manualEnabled},
  {toggles.turbo,core.turboEnabled}}) do
  pair[1].Text=pair[2] and 'ON' or 'OFF'
  pair[1].BackgroundColor3=pair[2] and Color3.fromRGB(30,104,86) or C.raised
 end
 turboStatus.Text='TURBO • '..tostring(core.turboMessage or '-')..'\nโตล่าสุด '..fmt(math.floor(core.turboGainRate or 0))..'/วิ  |  ดีสุด '..tostring(core.turboBestRate or 55)..' คลิก/วิ'
 turboStatus.TextColor3=core.turboEnabled and C.gold or C.muted
 flowStatus.Text='FLOW • คลิกส่งจริง '..tostring((core.manualPaused and core.lastActiveRate) or core.actualRate or 0)..'/วิ'..(core.manualPaused and ' (ก่อนพัก)' or '')..' | เป้าหมาย '..tostring(rateTarget)..'/วิ'..
   '\nกู้คืน UI '..tostring(core.flowRecovered or 0)..' ครั้ง  |  อ่านค่า '..tostring(core.flowDataSamples or 0)..' รอบ'..
   '\nPERF READ '..string.format('%.2f',core.perfReadAvgMs or 0)..'ms  |  HUD '..string.format('%.2f',core.perfUiAvgMs or 0)..'ms'..
   '  |  CACHE '..tostring(core.pathCacheHits or 0)..
   '\nMICRO-LAG '..tostring(core.microStutters or 0)..'  |  MAP '..string.format('%.0f',core.mapLastDurationMs or 0)..'ms'..
   '  |  RESET '..string.format('%.0f',core.resetLastDurationMs or 0)..'ms'..
   '\nLIVE EVENT '..tostring(core.liveEventUpdates or 0)..'  |  GC '..tostring(math.floor(core.healthLatestKB or 0))..'KB'
 flowStatus.TextColor3=C.gold
 if state.page==2 and state.benchmark and state.benchmark.paint then
  pcall(state.benchmark.paint)
 end
 -- The shared operational-status painter handles both modes; no hidden Quick draws.
 -- Quick HUD live size and progress are painted by paintLiveSize() as well.
end
local function action(f)
 return function()
  if not state.alive or not core.alive then return end
  local ok,err=pcall(f)
  if not ok then
   if state.ux then state.ux.safe('button-error',function()error(tostring(err))end) end
  end
  if state.ux then state.ux.safe('action-refresh',refresh) else pcall(refresh) end
 end
end
start.Activated:Connect(action(core.control.toggle))
qToggle.Activated:Connect(action(core.control.toggle))
emergency.Activated:Connect(action(function()core.control.stop(true)end))
toggles.eat.Activated:Connect(action(function()core.eat=not core.eat end))
toggles.reset.Activated:Connect(action(function()core.reset=not core.reset end))
toggles.map.Activated:Connect(action(function()core.map=not core.map end))
toggles.manual.Activated:Connect(action(function()core.control.setManualEnabled(not core.manualEnabled)end))
toggles.turbo.Activated:Connect(action(function()core.control.setTurboEnabled(not core.turboEnabled)end))
-- Shortcut buttons on Home; the source of truth remains core.reset/map/manualEnabled.
state.homeButtons.reset.Activated:Connect(action(function()core.reset=not core.reset end))
state.homeButtons.map.Activated:Connect(action(function()core.map=not core.map end))
state.homeButtons.manual.Activated:Connect(action(function()core.control.setManualEnabled(not core.manualEnabled)end))
slower.Activated:Connect(action(function()core.control.setRateIndex(core.rate-1)end))
faster.Activated:Connect(action(function()core.control.setRateIndex(core.rate+1)end))
save.Activated:Connect(action(function()
 local n=tonumber((tostring(entry.Text):gsub('[,%s]','')))
 if core.control.setCap(n) then entry.Text=fmt(core.manualCap)
 else entry.Text='';entry.PlaceholderText='กรอกจำนวนเต็มที่ถูกต้อง' end
end))
autoCap.Activated:Connect(action(function()core.control.autoCap();entry.Text=''end))
testMap.Activated:Connect(action(function()
 if state.ux and not state.ux.command('manual-map-test',6) then return end
 core.control.testMap()
end))
clearStats.Activated:Connect(action(core.control.clearStats))
-- V8.1.0 | Event-only button feedback. No per-frame animation or extra farm thread.
do
 local ux=state.ux
 local function report(control,msg)
  control.Activated:Connect(function()
   if not state.alive then return end
   ux.notify(msg)
  end)
 end
 report(start,'⚡ รับคำสั่งเริ่ม/หยุดแล้ว')
 report(qToggle,'⚡ รับคำสั่งจาก Quick HUD')
 report(emergency,'⛔ สั่งหยุดระบบแล้ว')
 report(testMap,'🗺️ กำลังตรวจคำขอข้ามแมพ')
 report(save,'💾 ตรวจสอบค่าขนาดเป้าหมายแล้ว')
 report(autoCap,'🔍 ขออ่านความจุจากเกม')
 report(clearStats,'🧹 ขอรีเซ็ตสถิติเซสชัน')
 report(state.homeButtons.reset,'🔄 สลับ Auto Reset แล้ว')
 report(state.homeButtons.map,'🗺️ สลับ Auto Map แล้ว')
 report(state.homeButtons.manual,'🖱️ สลับ Mouse Override แล้ว')
 report(toggles.turbo,'🚀 สลับ Turbo แล้ว')
 report(slower,'➖ ลดเป้าหมายคลิกแล้ว')
 report(faster,'➕ เพิ่มเป้าหมายคลิกแล้ว')
end

local function destroy()
 if not state.alive then return end
 if state.ux then state.ux.toastRevision=state.ux.toastRevision+1 end
 if state.ux then _G.NKMPJ_V81_UI_STATE=state.ux.capture() end
 state.alive=false;stopFX()
 if state.liveBridge then pcall(state.liveBridge.close) end
 titanSession.alive=false
 if _G[SESSION_KEY]==titanSession then _G[SESSION_KEY]=nil end
 fullTitleTween:Cancel();quickTitleTween:Cancel()
 state.quickFx.neonTween:Cancel()
 if qProgressTween then qProgressTween:Cancel() end
 if state.visualUltra and state.visualUltra.destroy then
  pcall(state.visualUltra.destroy)
 end
 for _,tw in pairs(rateTweens) do pcall(function()tw:Cancel()end) end
 for _,conn in ipairs(uiConnections) do pcall(function()conn:Disconnect()end) end
 core.onHumanPointer=nil
 core.onBenchmarkTick=nil
 core.onBenchmarkBoundary=nil
 core.onRateSnapshot=nil
 core.onLiveSize=nil
 core.onLightTelemetry=nil
 core.onStatusChanged=nil
 pcall(function()core.close()end)
 gui:Destroy()
 if _G.NKMPJ_V71_UI==state then _G.NKMPJ_V71_UI=nil end
end
state.destroy=destroy
titanSession.shutdown=function()
 if state.alive then destroy()
 elseif core and core.alive then pcall(function()core.close()end) end
 titanSession.alive=false
 if _G[SESSION_KEY]==titanSession then _G[SESSION_KEY]=nil end
end
closeButton.Activated:Connect(destroy)
-- A true Quick HUD close: completely stop + clean up all HUB overlays.
-- Unlike qFull (open main) and qMin (mini orb), X exits the script UI/core.
qExit.Activated:Connect(destroy)
entry.Text=core.manualCap and fmt(core.manualCap) or ''
selectPage(1);theme();applyPersonalization();fxSelect();refresh();setMode('full')
-- V7.9.11 HYBRID: event-driven size, everything else mouse-wake only.
-- No extra GUI polls. A burst of pointer events queues ONE full snapshot
-- after 200ms of quiet: HUD, chart and command deck all refresh together.
local wake={pending=false,lastMove=-math.huge,total=0}
local function paintAll()
 if not state.alive or not core.alive or not gui.Parent then return end
 if state.mode=='mini' then return end -- no visible stats to repaint
 local started=os.clock()
 if state.mode=='full' and state.page==2 and type(core.onRateSnapshot)=='function' then
  pcall(core.onRateSnapshot,core.actualRate or 0,core.control.getSize(),os.clock())
 end
 local ok,err=pcall(refresh)
 if not ok and state.ux then state.ux.safe('snapshot-error',function()error(tostring(err))end) end
 if state.mode=='full' and type(state.onSnapshotSmart)=='function' then
  local good,why=pcall(state.onSnapshotSmart)
  if not good then warn('NKMPJ command snapshot: '..tostring(why)) end
 end
 wake.total=wake.total+1
 local uiMs=math.max(0,(os.clock()-started)*1000)
 core.perfUiCount=(core.perfUiCount or 0)+1
 core.perfUiAvgMs=core.perfUiCount==1 and uiMs or (core.perfUiAvgMs*.8+uiMs*.2)
 core.perfUiPeakMs=math.max(core.perfUiPeakMs or 0,uiMs)
end
-- Unified UI dispatch: one deferred microtask, keyed jobs, fixed priority.
-- Live Size bypasses this queue to avoid delays; Status precedes Heavy Snapshot.
state.ux.flushUI=function()
 if state.ux.uiFlushing then return end
 state.ux.uiFlushing=true
 task.defer(function()
  local ux=state.ux
  local statusJob=ux.uiTasks.status
  local snapshotJob=ux.uiTasks.snapshot
  ux.uiTasks.status=false;ux.uiTasks.snapshot=false
  ux.uiFlushing=false
  if not state.alive or not core.alive or not gui.Parent then return end
  if statusJob and type(state.paintOperationalStatus)=='function' then
   ux.safe('status',state.paintOperationalStatus)
  end
  if snapshotJob then paintAll() end
 end)
end
state.ux.queueUI=function(kind)
 if not state.alive or not core.alive then return end
 state.ux.uiTasks[kind]=true
 state.ux.flushUI()
end
state.requestFullSnapshot=function()state.ux.queueUI('snapshot')end
-- The game core already reads size every ~0.10s. This callback gets a
-- throttled sample from that existing read and updates ONLY the number lanes.
core.onLiveSize=function(currentSize,currentCap)
 core.lastLiveCap=currentCap
 -- Quick HUD is the ONLY continuously painted size display.
 -- Keep values cached for Full Console snapshots, but do not repaint hidden UI.
 if not state.alive or state.mode~='quick' then return end
 if state.ux then state.ux.safe('quick-live-size',paintLiveSize,currentSize,currentCap)
 else pcall(paintLiveSize,currentSize,currentCap) end
end
-- V8.1.17.4: ISOLATED, READ-ONLY, UI EVENT BRIDGE.
-- No callback from the farm coroutine; unexpected UI errors can never stop eating.
state.liveBridge={sizeObject=nil,sizeConn=nil,capObject=nil,capConn=nil,extra={}}
function state.liveBridge.publish()
 if not state.alive or not core.alive then return end
 local b=state.liveBridge
 local obj=b.sizeObject
 if not obj or not obj.Parent then return end
 local ok,sz=pcall(function()return tonumber(((obj.Text or ''):gsub(',','')))end)
 if not ok or type(sz)~='number' or sz<0 then return end
 local cap=tonumber(core.manualCap)
 if not cap and b.capObject and b.capObject.Parent then
  local good,c=pcall(function()return tonumber(((b.capObject.Text or ''):gsub(',','')))end)
  if good and type(c)=='number' and c>0 then cap=c end
 end
 if type(cap)~='number' or cap<=0 then
  cap=tonumber(core.lastLiveCap) or tonumber(core.control.getCapacity())
 end
 if sz==core.lastLiveSize and cap==core.lastLiveCap then return end
 core.lastLiveSize=sz;core.lastLiveCap=cap;core.lastLiveSizeAt=os.clock()
 core.liveEventUpdates=core.liveEventUpdates+1
 if type(core.onLiveSize)=='function' then
  core.livePaints=core.livePaints+1
  pcall(core.onLiveSize,sz,cap)
 end
end
function state.liveBridge.bind()
 if not state.alive or not core.alive then return end
 local b=state.liveBridge
 local root=pg:FindFirstChild('ScreenGui')
 local sell=root and root:FindFirstChild('Sell')
 local sz=sell and sell:FindFirstChild('ProgressText')
 local shop=root and root:FindFirstChild('Shop')
 local frames=shop and shop:FindFirstChild('ShopFrames')
 local up=frames and frames:FindFirstChild('Upgrades')
 local lst=up and up:FindFirstChild('UpgradeList')
 local max=lst and lst:FindFirstChild('MaxSize')
 local uf=max and max:FindFirstChild('UpgradeFrame')
 local cap=uf and uf:FindFirstChild('Amount')
 if sz~=b.sizeObject then
  if b.sizeConn then b.sizeConn:Disconnect();b.sizeConn=nil end
  b.sizeObject=sz
  if sz and sz:IsA('TextLabel') then
   core.liveSourceRebinds=core.liveSourceRebinds+1
   b.sizeConn=sz:GetPropertyChangedSignal('Text'):Connect(function()
    pcall(state.liveBridge.publish)
   end)
  end
 end
 if cap~=b.capObject then
  if b.capConn then b.capConn:Disconnect();b.capConn=nil end
  b.capObject=cap
  if cap and cap:IsA('TextLabel') then
   b.capConn=cap:GetPropertyChangedSignal('Text'):Connect(function()
    pcall(state.liveBridge.publish)
   end)
  end
 end
 pcall(b.publish)
end
function state.liveBridge.close()
 local b=state.liveBridge
 if b.sizeConn then b.sizeConn:Disconnect();b.sizeConn=nil end
 if b.capConn then b.capConn:Disconnect();b.capConn=nil end
 for _,conn in ipairs(b.extra) do pcall(function()conn:Disconnect()end) end
 b.extra={}
end
pcall(state.liveBridge.bind)
table.insert(state.liveBridge.extra,pg.DescendantAdded:Connect(function(obj)
 if obj.Name=='ProgressText' or obj.Name=='Amount' then
  task.defer(function()if state.alive then pcall(state.liveBridge.bind)end end)
 end
end))
-- UI-only pointer wake: the legacy farm Mouse Override is never modified.
table.insert(state.liveBridge.extra,UIS.InputChanged:Connect(function(input)
 if not state.alive or not core.alive then return end
 if input.UserInputType==Enum.UserInputType.MouseMovement and type(core.onHumanPointer)=='function' then
  pcall(core.onHumanPointer,os.clock())
 end
end))
-- UI-only readback: reuse the existing status pulse, never touch farm timing.
-- Event signals are immediate; this small Quick-only backup handles missed signals,
-- reparented game GUIs and capacities that load after the current size.
task.spawn(function()
 local lastSize=nil
 local lastCap=nil
 local lastBind=0
 while state.alive and core.alive and gui.Parent do
  pcall(function()
   if state.mode~='mini' then
    if type(state.paintLiveFarmTime)=='function' then state.paintLiveFarmTime() end
    if type(state.paintOperationalStatus)=='function' then state.paintOperationalStatus() end
    if state.mode=='quick' then
     local now=os.clock()
     local b=state.liveBridge
     if now-lastBind>=2 or not b.sizeObject or not b.sizeObject.Parent then
      lastBind=now
      pcall(b.bind)
     end
     -- Read game-owned size/capacity; do not use the score or a synthetic counter.
     local sz=core.control.getSize()
     if type(sz)~='number' and b.sizeObject and b.sizeObject.Parent then
      sz=tonumber(((b.sizeObject.Text or ''):gsub('[,%s]','')))
     end
     local cap=core.control.getCapacity()
     if (type(cap)~='number' or cap<=0) and b.capObject and b.capObject.Parent then
      cap=tonumber(((b.capObject.Text or ''):gsub('[,%s]','')))
     end
     if type(cap)~='number' or cap<=0 then
      cap=core.lastLiveCap or core.lastDisplayCapacity
     end
     if type(sz)=='number' and sz>=0 then
      if sz~=lastSize or cap~=lastCap then
       lastSize=sz;lastCap=cap
       core.lastLiveSize=sz;core.lastLiveCap=cap;core.lastLiveSizeAt=now
       core.liveFallbackUpdates=(core.liveFallbackUpdates or 0)+1
       if type(core.onLiveSize)=='function' then
        pcall(core.onLiveSize,sz,cap)
       end
      end
     elseif lastSize~=nil then
      -- Retain last known value during a transient map UI swap; don't invent 0.
      if cap~=lastCap then lastCap=cap;pcall(core.onLiveSize,lastSize,cap) end
     else
      paintLiveSize(nil,nil)
     end
    end
   end
  end)
  task.wait(state.mode=='quick' and .12 or .4)
 end
end)
core.onHumanPointer=function(now)
 if not state.alive or not core.alive or state.mode=='mini' then return end
 wake.lastMove=tonumber(now) or os.clock()
 if wake.pending then return end
 wake.pending=true
 task.spawn(function()
  while state.alive and core.alive and gui.Parent and os.clock()-wake.lastMove<.20 do
   task.wait(.06)
  end
  wake.pending=false
  if state.alive and core.alive then state.ux.queueUI('snapshot') end
 end)
end
print('NKMPJ HUB V7.7 | STABLE SIGNATURE | single title shimmer, fixed numeric lanes, 0.14s dock progress, no audio')
-- END OF SCRIPT | NKMPJ HUB V7.4 CELESTIAL LUXE HYBRID MASTER

local function installSmartCommandV75()

-- ============================================================================
-- NKMPJ HUB V7.5 | SMART COMMAND EDITION
-- Additive command deck. V7.4 farm, reset, map, logo, quick HUD and mini orb
-- are preserved without changing their original engine functions.
-- ============================================================================
subtitle.Text='ENGINE ISOLATED  /  V8.1.17.4'
lookStatus.Text='V8.1.17.4 • ENGINE RESTORE | LIVE SIZE'
gui.Name='NKMPJ_HUB_V80'
local HttpService=game:GetService('HttpService')
-- Existing JSON format stays compatible with V7.5 backups.
local BACKUP_PATH='NKMPJ_V77_Settings.json'
local LEGACY_BACKUP_PATH='NKMPJ_V75_Settings.json'
local smart={preset='BALANCED',events={},lastMode='',lastMessage='',lastResets=core.resetCount or 0,
 lastMaps=core.mapCount or 0,lastStalls=core.stalls or 0,lastUISample=os.clock(),
 lastDataOK=false,lastError='',storageOK=type(writefile)=='function' and type(readfile)=='function'}
state.smart=smart
local function logEvent(labelText)
 if not state.alive then return end
 local message=tostring(labelText or 'เหตุการณ์'):sub(1,145)
 if smart.events[1] and smart.events[1].message==message and
    os.clock()-smart.events[1].at<3 then return end
 table.insert(smart.events,1,{message=message,at=os.clock(),elapsed=os.clock()-(core.hubStartedAt or os.clock())})
 while #smart.events>18 do table.remove(smart.events) end
end
 state.logSmart=logEvent
local function statusHint(s,good)
 smart.lastError=tostring(s)
 if good then logEvent(s) end
end

-- Entry point is INSIDE the existing System tab; no fifth top navigation tab.
local smartEntry=button(settings,'🧰  ขั้นสูง • พรีเซ็ต / สำรอง / วินิจฉัย  ›',3,689,355,35,C.raised,C.gold,9)
smartEntry.TextSize=12
jewelButton(smartEntry,C.gold)

local commandDeck=frame(shell,13,145,W-26,195,C.black,10,1)
commandDeck.Visible=false
local deckTop=frame(commandDeck,0,0,364,28,Color3.fromRGB(34,31,24),9)
local backButton=button(deckTop,'‹',4,3,29,22,C.raised,C.gold,7)
backButton.TextSize=22
local deckTitle=text(deckTop,'🧠 ศูนย์ควบคุมขั้นสูง  /  V8.1.17.4',41,1,290,25,12,true,C.pearl)
local deckDot=frame(deckTop,343,11,7,7,C.mint,4)

local deckNav=frame(commandDeck,0,32,364,29,Color3.fromRGB(21,22,18),9)
local deckTabs={}
for i,name in ipairs({'🩺 สุขภาพ','🕒 ประวัติ','🧰 โปรไฟล์'}) do
 local widths={120,97,135}
 local xs={2,124,224}
 local b=button(deckNav,name,xs[i],2,widths[i],25,C.raised,C.muted,7)
 b.TextSize=(i==3 and 10 or 11)
 deckTabs[i]=b
end
local smartPages={}
for i=1,3 do
 local sc=make('ScrollingFrame',commandDeck,{
  Position=UDim2.fromOffset(0,65),Size=UDim2.fromOffset(364,130),
  BackgroundTransparency=1,BorderSizePixel=0,Visible=i==1,
  ScrollBarThickness=3,ScrollBarImageColor3=C.gold,
  ScrollingDirection=Enum.ScrollingDirection.Y,
  CanvasSize=UDim2.fromOffset(364,500)
 })
 smartPages[i]=sc
end
local function smartHeading(parent,y,s)
 text(parent,s,6,y,346,19,12,true,C.gold)
 frame(parent,6,y+19,344,1,C.edge,0,.68)
end
local function readout(parent,y,s)
 local box=frame(parent,5,y,350,30,Color3.fromRGB(36,34,28),9)
 local key=text(box,s,10,2,170,26,11,false,C.muted)
 local value=text(box,'—',177,2,162,26,11,true,C.pearl,Enum.TextXAlignment.Right)
 return value,box,key
end
-- Monitor: live observed values, with explicit unavailable states.
local monitor=smartPages[1]
smartHeading(monitor,0,'LIVE SYSTEM MONITOR')
local monitorMode=readout(monitor,27,'สถานะระบบ')
local monitorRate=readout(monitor,61,'คลิกจริง / วินาที')
local monitorProbe=readout(monitor,95,'ตรวจค้าง / รอบ')
local monitorSession=readout(monitor,129,'เวลาใช้งาน')
local monitorSize=readout(monitor,163,'ขนาดตัวละคร')
smartHeading(monitor,205,'SYSTEM HEALTH  /  ตรวจสอบได้จริง')
local healthEngine=readout(monitor,232,'Engine + UI')
local healthData=readout(monitor,266,'ข้อมูลจากเกม')
local healthStorage=readout(monitor,300,'บันทึกลงไฟล์')
local healthActivity=readout(monitor,334,'เหตุการณ์ล่าสุด')
local healthTest=readout(monitor,368,'SELF-TEST / 6 จุด')
local healthUI=readout(monitor,402,'UI / Error Count')
local healthNote=text(monitor,'สถานะสีเขียวหมายถึงตรวจสอบส่วนประกอบได้\nไม่ใช่การรับประกันว่าเกมทำงานถูกต้องทุกกรณี',8,441,335,44,10,false,C.muted)
healthNote.TextWrapped=true;healthNote.TextYAlignment=Enum.TextYAlignment.Top
monitor.CanvasSize=UDim2.fromOffset(364,504)

-- Timeline: meaningful changes; no fabricated event entries.
local history=smartPages[2]
smartHeading(history,0,'ACTIVITY TIMELINE  /  ล่าสุด 12 รายการ')
local historyClear=button(history,'ล้างประวัติ',258,0,96,21,C.raised,C.gold,7)
historyClear.TextSize=10
local historyRows={}
for i=1,12 do
 local row=frame(history,5,28+(i-1)*31,349,28,Color3.fromRGB(34,34,28),8)
 local at=text(row,'—',8,2,61,24,10,true,C.gold)
 local msg=text(row,'—',72,2,267,24,10,false,C.pearl)
 historyRows[i]={at,msg,row}
end
history.CanvasSize=UDim2.fromOffset(364,408)
local function drawHistory()
 for i,row in ipairs(historyRows) do
  local e=smart.events[i]
  row[3].Visible=e~=nil
  if e then
   row[1].Text=clock(e.elapsed)
   row[2].Text=e.message
  end
 end
end
historyClear.Activated:Connect(function()
 smart.events={}
 logEvent('เริ่มบันทึกประวัติรอบใหม่')
 drawHistory()
end)

-- Presets, backup, and Advanced Settings coexist in one scrollable tool page.
local config=smartPages[3]
smartHeading(config,0,'SMART PRESETS')
local presetBtns={}
for i,name in ipairs({'STABLE','BALANCED','CUSTOM'}) do
 local b=button(config,name,5+(i-1)*119,27,112,32,C.raised,C.pearl,8)
 b.TextSize=11;presetBtns[i]=b
end
local presetInfo=text(config,'เลือกโปรไฟล์ = ใช้ความเร็วคงที่ และปิด Turbo (เปิดใหม่ในแท็บระบบ)',7,63,350,26,10,false,C.muted)
smartHeading(config,96,'SETTINGS BACKUP  /  JSON')
local saveSettings=button(config,'บันทึกไฟล์',5,122,169,34,C.raised,C.gold,8)
local restoreSettings=button(config,'เรียกคืนค่า',185,122,169,34,C.raised,C.gold,8)
saveSettings.TextSize=12;restoreSettings.TextSize=12
local backupNote=text(config,'ยังไม่ได้บันทึก',7,160,344,38,10,false,C.muted)
backupNote.TextWrapped=true;backupNote.TextYAlignment=Enum.TextYAlignment.Top
smartHeading(config,208,'ADVANCED SETTINGS  /  ค่าตรวจสอบ')
local advancedValue={}
local advancedKeys={
 {'stallProbeSeconds','ช่วงตรวจคะแนน',4,12,1,' วิ'},
 {'stallGraceSeconds','เวลาผ่อนผัน',5,20,1,' วิ'},
 {'mapAttemptCooldown','พักก่อนเปลี่ยนแมพ',20,90,2,' วิ'}
}
for i,p in ipairs(advancedKeys) do
 local y=236+(i-1)*43
 local f=frame(config,5,y,349,38,Color3.fromRGB(37,34,26),9)
 text(f,p[2],9,2,174,34,11,false,C.pearl)
 local minus=button(f,'−',182,5,34,28,C.raised,C.pearl,7)
 local val=text(f,'—',217,5,87,28,11,true,C.gold,Enum.TextXAlignment.Center)
 local plus=button(f,'+',308,5,34,28,C.raised,C.pearl,7)
 local key=p[1]
 advancedValue[key]=val
 local function change(d)
  if not state.alive then return end
  local old=tonumber(core[key]) or p[3]
  core[key]=math.clamp(math.floor(old+d),p[3],p[4])
  smart.preset='CUSTOM'
  logEvent(p[2]..' = '..tostring(core[key])..' วิ')
 end
 minus.Activated:Connect(function()change(-p[5])end)
 plus.Activated:Connect(function()change(p[5])end)
end
local advNote=text(config,'การแก้ช่วงตรวจจะมีผลในรอบตรวจถัดไป\nระบบยืนยันคะแนนค้างสองรอบยังคงเดิม',8,372,344,37,10,false,C.muted)
advNote.TextWrapped=true;advNote.TextYAlignment=Enum.TextYAlignment.Top
local settingsStatus=text(config,'',7,414,345,34,10,true,C.gold)
settingsStatus.TextWrapped=true
config.CanvasSize=UDim2.fromOffset(364,466)
for _,b in ipairs({backButton,historyClear,saveSettings,restoreSettings}) do jewelButton(b,C.edge) end
for _,b in ipairs(deckTabs) do jewelButton(b,C.edge) end
for _,b in ipairs(presetBtns) do jewelButton(b,C.edge) end

 local smartTab=1
 local updateSmart -- assigned below; event callbacks may invoke it after initialization
 local function showSmartTab(i)
 smartTab=i
 for j,pg in ipairs(smartPages) do pg.Visible=j==i end
 for j,b in ipairs(deckTabs) do
  b.BackgroundColor3=j==i and Color3.fromRGB(83,66,39) or C.raised
  b.TextColor3=j==i and C.pearl or C.muted
 end
  if i==2 then drawHistory() end
  if updateSmart then updateSmart(false) end
 end
 for i,b in ipairs(deckTabs) do local at=i;b.Activated:Connect(function()showSmartTab(at)end)end
local function closeSmart()
 commandDeck.Visible=false
 pages[3].Visible=state.page==3
end
smartEntry.Activated:Connect(function()
 pages[3].Visible=false
 commandDeck.Visible=true
 showSmartTab(1)
  logEvent('เปิด Smart Command')
  if updateSmart then updateSmart(false) end
 end)
 backButton.Activated:Connect(closeSmart)
for _,b in ipairs(tabs) do
 b.Activated:Connect(function()
  if commandDeck.Visible then commandDeck.Visible=false end
 end)
end

local function choosePreset(name)
 if name=='STABLE' then
  core.stallProbeSeconds=4
  core.stallGraceSeconds=8
  core.mapAttemptCooldown=22
  core.control.setRateIndex(3) -- 55 requests/second, not automatically started
 elseif name=='BALANCED' then
  core.stallProbeSeconds=5
  core.stallGraceSeconds=7
  core.mapAttemptCooldown=20
  core.control.setRateIndex(5) -- 85; original V7.4 default
 elseif name~='CUSTOM' then return end
 smart.preset=name
 logEvent('เลือกโปรไฟล์ '..name)
end
for i,name in ipairs({'STABLE','BALANCED','CUSTOM'}) do
 presetBtns[i].Activated:Connect(function()choosePreset(name)end)
end
-- Boot STABLE at 55, then arm Adaptive Turbo; still START-gated.
choosePreset('STABLE')
core.control.setTurboEnabled(true)
-- Mark manual changes as custom, without interfering with the existing handlers.
for _,b in ipairs({slower,faster}) do
 b.Activated:Connect(function()smart.preset='CUSTOM' end)
end

local function snapshot()
 return {
  format='NKMPJ_V75_SETTINGS',version=1,
  eat=core.eat,reset=core.reset,map=core.map,manualEnabled=core.manualEnabled,
  turboEnabled=core.turboEnabled,
  rateIndex=core.rate,manualCap=core.manualCap or false,
  stallProbeSeconds=core.stallProbeSeconds,
  stallGraceSeconds=core.stallGraceSeconds,
  mapAttemptCooldown=core.mapAttemptCooldown,
  preset=smart.preset,
  theme=state.theme,fx=state.fx,surface=state.surface,motion=state.motion,
  windowSize=state.windowSize,uiMode=state.mode,
  positions={
   full={shell.Position.X.Offset,shell.Position.Y.Offset},
   quick={quick.Position.X.Offset,quick.Position.Y.Offset},
   mini={mini.Position.X.Offset,mini.Position.Y.Offset}
  }
 }
end
local function applySettings(data)
 if type(data)~='table' or data.format~='NKMPJ_V75_SETTINGS' or data.version~=1 then
  return false,'ไฟล์การตั้งค่าไม่อยู่ในรูปแบบที่รองรับ'
 end
 local function numeric(v,low,high,fallback)
  v=tonumber(v)
  if not v or v~=v or v==math.huge or v==-math.huge then return fallback end
  return math.clamp(math.floor(v),low,high)
 end
 for _,key in ipairs({'eat','reset','map'}) do
  if type(data[key])=='boolean' then core[key]=data[key] end
 end
 if type(data.manualEnabled)=='boolean' then core.control.setManualEnabled(data.manualEnabled) end
 if data.manualCap==false then
  core.control.autoCap()
 elseif type(data.manualCap)=='number' and data.manualCap>=1 and data.manualCap<=1e15 and
  data.manualCap==math.floor(data.manualCap) then
  core.control.setCap(data.manualCap)
 end
 core.control.setRateIndex(numeric(data.rateIndex,1,7,core.rate))
 -- Legacy backups without turboEnabled restore to fixed/manual speed.
 if type(data.turboEnabled)=='boolean' then core.control.setTurboEnabled(data.turboEnabled) end
 core.stallProbeSeconds=numeric(data.stallProbeSeconds,4,12,core.stallProbeSeconds)
 core.stallGraceSeconds=numeric(data.stallGraceSeconds,5,20,core.stallGraceSeconds)
 core.mapAttemptCooldown=numeric(data.mapAttemptCooldown,20,90,core.mapAttemptCooldown)
 state.theme=numeric(data.theme,1,3,state.theme)
 state.fx=numeric(data.fx,0,3,state.fx)
 state.surface=numeric(data.surface,1,3,state.surface)
 state.motion=numeric(data.motion,1,3,state.motion)
 state.windowSize=1 -- Legacy backup compatibility: visual size is permanently Compact
 smart.preset=({STABLE=true,BALANCED=true,CUSTOM=true})[data.preset] and data.preset or 'CUSTOM'
 _G.NKMPJ_V71_THEME=state.theme;_G.NKMPJ_V71_FX=state.fx
 _G.NKMPJ_V72_SURFACE=state.surface;_G.NKMPJ_V72_MOTION=state.motion
 _G.NKMPJ_V72_SIZE=state.windowSize
 if type(data.positions)=='table' then
  for k,o in pairs({full=shell,quick=quick,mini=mini}) do
   local coords=data.positions[k]
   if type(coords)=='table' and type(coords[1])=='number' and type(coords[2])=='number' then
    local ww=o==shell and W*shellScale.Scale or (o==quick and qFootW or MINI)
    local hh=o==shell and H*shellScale.Scale or (o==quick and qFootH or MINI)
    local xx,yy=clampPos(coords[1],coords[2],ww,hh)
    o.Position=UDim2.fromOffset(xx,yy)
   end
  end
 end
 entry.Text=core.manualCap and fmt(core.manualCap) or ''
 theme();applyPersonalization();fxSelect()
 -- Deliberately NEVER turn farming on as a side effect of loading settings.
 -- Restoring a previous UI mode is also optional; stay in this command deck.
 refresh()
 return true,'คืนค่าการตั้งค่าเรียบร้อย (ไม่ได้เริ่มฟาร์มอัตโนมัติ)'
end
saveSettings.Activated:Connect(function()
 local ok,json=pcall(function()return HttpService:JSONEncode(snapshot())end)
 if not ok then backupNote.Text='สร้างข้อมูลสำรองไม่สำเร็จ';return end
 _G.NKMPJ_V75_SESSION_BACKUP=json
 if type(writefile)=='function' then
  local wrote,why=pcall(writefile,BACKUP_PATH,json)
  if wrote then
   backupNote.Text='บันทึกลง '..BACKUP_PATH..' แล้ว'
   logEvent('บันทึกการตั้งค่าลงไฟล์แล้ว')
  else
   backupNote.Text='บันทึกในเซสชันเท่านั้น (เขียนไฟล์ไม่สำเร็จ)'
   logEvent('บันทึกไฟล์ล้มเหลว: '..tostring(why):sub(1,40))
  end
 else
  backupNote.Text='บันทึกเฉพาะเซสชัน (ไม่มี writefile)'
  logEvent('บันทึกการตั้งค่าเฉพาะเซสชัน')
 end
end)
restoreSettings.Activated:Connect(function()
 local json=nil
 if type(readfile)=='function' then
  local ok,value=pcall(readfile,BACKUP_PATH)
  if ok and type(value)=='string' then json=value end
  -- Automatic read-only migration from older V7.5 backup files.
  if not json then
   local legacyOK,legacy=pcall(readfile,LEGACY_BACKUP_PATH)
   if legacyOK and type(legacy)=='string' then json=legacy end
  end
 end
 if not json then json=_G.NKMPJ_V75_SESSION_BACKUP end
 if type(json)~='string' then
  backupNote.Text='ไม่พบไฟล์สำรองหรือข้อมูลเซสชัน';return
 end
 local ok,data=pcall(function()return HttpService:JSONDecode(json)end)
 if not ok then backupNote.Text='อ่าน JSON ไม่สำเร็จ';return end
 local completed,valid,reason=pcall(applySettings,data)
 if not completed then
  backupNote.Text='คืนค่าไม่ได้: '..tostring(valid):sub(1,64)
 elseif valid then
  backupNote.Text=reason
  logEvent('คืนค่าการตั้งค่าแล้ว')
 else
  backupNote.Text=tostring(reason)
 end
end)

-- Capture manual commands as requested actions, separate from confirmed results.
for _,item in ipairs({
 {toggles.eat,'ฟาร์มอัตโนมัติ', 'eat'},
 {toggles.reset,'รีเซ็ตอัตโนมัติ','reset'},
 {toggles.map,'เปลี่ยนแมพอัตโนมัติ','map'},
 {state.homeButtons.reset,'รีเซ็ตอัตโนมัติ (Home)','reset'},
 {state.homeButtons.map,'เปลี่ยนแมพอัตโนมัติ (Home)','map'}
}) do
 item[1].Activated:Connect(function()
  logEvent(item[2]..' '..(core[item[3]] and 'ON' or 'OFF'))
 end)
end
for _,item in ipairs({
 {start,'กดเริ่ม/หยุดระบบ'},
 {qToggle,'กดเริ่ม/หยุดจาก Quick HUD'},
 {emergency,'สั่งหยุดฉุกเฉิน'},
 {testMap,'กดทดสอบเปลี่ยนแมพ'},
 {clearStats,'สั่งล้างสถิติ'},
 {save,'กดบันทึกขนาดสูงสุด'},
 {autoCap,'เปลี่ยนเป็นอ่านขนาดจากเกม'}
}) do
 item[1].Activated:Connect(function()logEvent(item[2])end)
end
local priorState=nil
local priorMessage=nil
local priorActive=nil
updateSmart=function(logOnly)
 if not state.alive or not core.alive then return end
 local mode=core.manualPaused and 'USER PAUSED' or (core.resetPending and 'RESET' or
  (core.mapBusy and 'MAP CHANGE' or (core.on and 'FARMING' or 'STANDBY')))
 if mode~=priorState then
  logEvent('สถานะเปลี่ยนเป็น '..mode)
  priorState=mode
 end
 if core.resetCount~=smart.lastResets then
  if (core.resetCount or 0)>(smart.lastResets or 0) then
   logEvent('รีเซ็ตสำเร็จทั้งหมด '..tostring(core.resetCount or 0)..' ครั้ง')
   if state.ux then state.ux.notify('✅ รีเซ็ตสำเร็จ') end
  else logEvent('ตัวนับรีเซ็ตถูกล้าง') end
  smart.lastResets=core.resetCount
 end
 if core.mapCount~=smart.lastMaps then
  if (core.mapCount or 0)>(smart.lastMaps or 0) then
   logEvent('ยืนยันเปลี่ยนแมพ '..tostring(core.mapCount or 0)..' ครั้ง')
   if state.ux then state.ux.notify('🗺️ เปลี่ยนแมพสำเร็จ') end
  else logEvent('ตัวนับแมพถูกล้าง') end
  smart.lastMaps=core.mapCount
 end
 if core.stalls~=smart.lastStalls then
  if core.stalls and core.stalls>0 then logEvent('ตรวจคะแนนค้าง '..tostring(core.stalls)..'/2') end
  smart.lastStalls=core.stalls
 end
 local message=''
 local messageOK,readMessage=pcall(core.control.getMessage)
 if messageOK and type(readMessage)=='string' then message=readMessage end
 if message~=priorMessage then
  if message~='' and message~='กำลังกินดิน' and message~='ระบบพร้อมทำงาน' then
   logEvent(message)
  end
  priorMessage=message
 end
 -- Poll only lightweight event changes in the background (no GUI painting).
 -- Game data and command-deck rendering happen exclusively on user snapshots.
 if logOnly or not commandDeck.Visible then return end
 local pOK,p=pcall(core.control.getSize)
 local capOK,cap=pcall(core.control.getCapacity)
 local dataOK=pOK and capOK and type(p)=='number' and type(cap)=='number' and cap>0
 smart.lastDataOK=dataOK
 local elapsed=(core.activeTotal or 0)+(core.on and core.activeStart and os.clock()-core.activeStart or 0)
 monitorMode.Text=mode
 monitorMode.TextColor3=core.on and C.mint or C.gold
 monitorRate.Text=tostring(core.actualRate or 0)..' / '..tostring(core.control.rates[core.rate] or 0)
 monitorProbe.Text=tostring(core.stalls or 0)..'/2  |  '..tostring(core.stallProbeSeconds or 5)..' วิ'
 monitorSession.Text=clock(elapsed)
 monitorSize.Text=dataOK and fmt(p)..' / '..fmt(cap) or 'ไม่พบข้อมูล'
 healthEngine.Text=core.alive and gui.Parent and 'ทำงานอยู่' or 'ไม่พร้อม'
 healthEngine.TextColor3=core.alive and C.mint or C.rose
 healthData.Text=dataOK and 'อ่านค่าได้' or 'ข้อมูลไม่พร้อม'
 healthData.TextColor3=dataOK and C.mint or C.gold
 healthStorage.Text=smart.storageOK and 'รองรับไฟล์' or 'เฉพาะเซสชัน'
 healthStorage.TextColor3=smart.storageOK and C.mint or C.gold
 healthActivity.Text=smart.events[1] and smart.events[1].message or 'ยังไม่มีเหตุการณ์'
 healthActivity.TextSize=10
 healthTest.Text=state.ux.tests.status
 healthTest.TextColor3=#state.ux.tests.problems==0 and C.mint or C.gold
 healthUI.Text=tostring(state.ux.errors or 0)..' error(s)'
 healthUI.TextColor3=(state.ux.errors or 0)==0 and C.mint or C.gold
 deckDot.BackgroundColor3=dataOK and core.alive and C.mint or C.gold
 for i,b in ipairs(presetBtns) do
  local selected=({'STABLE','BALANCED','CUSTOM'})[i]==smart.preset
  b.BackgroundColor3=selected and Color3.fromRGB(90,72,43) or C.raised
  b.TextColor3=selected and C.pearl or C.muted
 end
 for _,p in ipairs(advancedKeys) do
  advancedValue[p[1]].Text=tostring(core[p[1]] or p[3])..p[6]
 end
 settingsStatus.Text='โปรไฟล์: '..smart.preset..'  |  '..mode
 settingsStatus.TextColor3=core.on and C.mint or C.gold
 if smartTab==2 then drawHistory() end
 smart.lastUISample=os.clock()
end
logEvent('Smart Command V8.1.17.4 • SAFE MAP GUARD พร้อมใช้งาน')
 showSmartTab(1)
 updateSmart(false)
 state.onSnapshotSmart=function()updateSmart(false)end
 -- Unified scheduler: observe existing core status changes and its 2-second
 -- sample tick. All work is log-only; heavy UI stays mouse-wake triggered.
core.onLightTelemetry=function()
 updateSmart(true)
 -- Reduce only decorative work if the existing core detects a sustained gap.
 local ux=state.ux
 if ux and state.alive then
  local now=os.clock()
  local overloaded=(core.stutterQuietUntil or 0)>now or (core.perfUiAvgMs or 0)>14
  if overloaded then
   ux.perfUntil=math.max(ux.perfUntil or 0,now+12)
   if not ux.perfPaused then
    ux.perfPaused=true
    stopFX();fullTitleTween:Cancel();quickTitleTween:Cancel()
    if type(state.logSmart)=='function' then state.logSmart('PERF BUDGET: พักแอนิเมชันชั่วคราว') end
   end
  elseif ux.perfPaused and now>=(ux.perfUntil or 0) then
   ux.perfPaused=false
   if state.mode=='full' then startFX();updateTitleShimmer(state.mode) end
  end
  if state.mode=='quick' then state.syncQuickMotion() end
 end
 local now=os.clock()
 if now-(core.healthLastAt or 0)<16 then return end
 core.healthLastAt=now
 local kbs=nil
 if type(gcinfo)=='function' then
  local ok,result=pcall(gcinfo)
  if ok and type(result)=='number' then kbs=result end
 end
 if kbs then
  core.healthLatestKB=kbs
  core.healthPeakKB=math.max(core.healthPeakKB or 0,kbs)
 end
 core.healthStaleSeconds=math.max(0,now-(core.healthLastGoodAt or now))
 local samples=core.healthSamples
 samples[#samples+1]={at=now,memoryKB=kbs,stutters=core.microStutters or 0,
  rate=core.actualRate or 0,stale=core.healthStaleSeconds}
 if #samples>16 then table.remove(samples,1) end
end
core.onStatusChanged=function()
 updateSmart(true)
 -- Paint only visible status. Multi-task dispatcher coalesces repeated changes.
 if state.ux then state.ux.queueUI('status') end
end
print('NKMPJ HUB V8.1.17.4 | ENGINE RESTORE + COMPACT UI')

end
installSmartCommandV75()


-- ============================================================================
-- V7.6 CELESTIAL SIGNATURE ULTRA: VISUAL ONLY, additive to V7.5 Smart Command.
-- No engine loops, reset logic, map logic, input hooks or gameplay parameters
-- are altered by this extension. All new motion is mode- and FX-level-aware.
-- ============================================================================
local function installSignatureUltraV76()
 local ultra={history={},lastSample=0,lastGraph=0,lastRate=nil,lastSize=nil,orbits={},uiTweens={}}
 state.visualUltra=ultra
 local function cseq(a,b)
  return ColorSequence.new(a,b)
 end
 local function tween(o,goal,duration,style)
  local t=TS:Create(o,TweenInfo.new(duration or .24,style or Enum.EasingStyle.Quad,Enum.EasingDirection.Out),goal)
  t:Play()
  return t
 end
 local function palette()
  return palettes[state.theme] or palettes[1]
 end
 local function tintBackground(o,a,b)
  if not o or not o.Parent then return end
  local g=o:FindFirstChildOfClass('UIGradient')
  if g then g.Color=cseq(a,b) end
 end

 -- Use existing rings, not another emblem border or a duplicate logo.
 local emblemDotA=frame(logoSeat,19,0,4,4,C.gold,2,.06)
 local emblemDotB=frame(logoSeat,19,38,3,3,C.cyan,2,.12)
 perfectCircle(emblemDotA);perfectCircle(emblemDotB)
 emblemDotA.Active=false;emblemDotB.Active=false
 local gemDotA=frame(gemOuter,21,0,3,3,C.gold,2,.65)
 local gemDotB=frame(gemOuter,21,42,3,3,C.cyan,2,.75)
 perfectCircle(gemDotA);perfectCircle(gemDotB)
 gemDotA.Active=false;gemDotB.Active=false
 local reactorGradient=gemInner:FindFirstChildOfClass('UIGradient')
 local heroGradient=hero:FindFirstChildOfClass('UIGradient')
 local headerGradient=header:FindFirstChildOfClass('UIGradient')
 local quickGradient=quick:FindFirstChildOfClass('UIGradient')
 local homeReflection=reflection

 -- Add JUST ONE faint horizon line to the graph: no new enclosing frames.
 local graphBaseline=frame(chartBg,10,27,341,1,C.edge,0,.78)
 graphBaseline.Active=false
 local velocityLabel=text(stats,'เก็บข้อมูล...',263,135,96,21,10,true,C.muted,Enum.TextXAlignment.Right)
 rateText.Size=UDim2.fromOffset(260,21)
 local themeNote=text(look,'✦ PREMIUM THEME STUDIO',5,175,335,12,10,true,C.gold)
 hint.Text='โลโก้มีชีวิต • Liquid Champagne • กราฟข้อมูลจริง'
 miniHelp.Text='Full / Quick / Mini Orb  |  ไม่มีเสียง'

 local themeCards={}
 for i,b in ipairs(themeButtons) do
  themeCards[i]=b.Parent
  for _,child in ipairs(b.Parent:GetChildren()) do
   if child:IsA('Frame') and child.Size.X.Offset==24 then
    tintBackground(child,palettes[i].a,palettes[i].b)
    child.BackgroundColor3=palettes[i].a
   end
  end
 end

 local contrast={
  Color3.fromRGB(39,33,24),  -- Royal champagne
  Color3.fromRGB(19,34,41),  -- Cyber aurora
  Color3.fromRGB(32,24,40)   -- Nova amethyst
 }
 function ultra.applyTheme()
  local pal=palette()
  local bg=contrast[state.theme]
  if headerGradient then headerGradient.Color=cseq(bg:Lerp(pal.b,.19),Color3.fromRGB(15,18,17)) end
  if heroGradient then heroGradient.Color=cseq(bg:Lerp(pal.a,.15),Color3.fromRGB(23,23,21)) end
  if quickGradient then quickGradient.Color=cseq(bg:Lerp(pal.a,.11),C.black) end
  if reactorGradient then reactorGradient.Color=cseq(pal.a,pal.b) end
  tintBackground(gemOuter,bg:Lerp(pal.a,.18),C.deep)
  gemInner.BackgroundColor3=pal.b
  gemOrbit.BackgroundColor3=C.deep
  shellStroke.Color=pal.b
  nav.BackgroundColor3=bg:Lerp(C.black,.65)
  hero.BackgroundColor3=bg
  themeNote.TextColor3=pal.a
  qState.TextColor3=core.on and C.mint or pal.a
  velocityLabel.TextColor3=pal.a
  graphBaseline.BackgroundColor3=pal.b
  progressShine.BackgroundColor3=pal.sub
  actionSheen.BackgroundColor3=pal.sub
  homeReflection.BackgroundColor3=pal.sub
  gemDotA.BackgroundColor3=pal.a
  gemDotB.BackgroundColor3=pal.sub
  emblemDotA.BackgroundColor3=pal.a
  emblemDotB.BackgroundColor3=pal.sub
  for i,b in ipairs(tabs) do
   if i==state.page then
    b.BackgroundColor3=bg:Lerp(pal.a,.32)
    b.TextColor3=pal.sub
   else
    b.BackgroundColor3=bg:Lerp(C.black,.66)
    b.TextColor3=C.muted
   end
  end
  for i,f in ipairs(themeCards) do
   if f then
    local st=f:FindFirstChildOfClass('UIStroke')
    if st then st.Color=palettes[i].a;st.Transparency=i==state.theme and .18 or .78 end
   end
  end
 end
 function ultra.selectPage(i)
  if i==2 then rateHeights={} end
  local pal=palette()
  for j,b in ipairs(tabs) do
   b.BackgroundColor3=j==i and contrast[state.theme]:Lerp(pal.a,.32)
                      or contrast[state.theme]:Lerp(C.black,.66)
   b.TextColor3=j==i and pal.sub or C.muted
  end
  -- No animated navigation rail: tab background alone indicates selection.
 end
 function ultra.stopFX()
  homeReflection.BackgroundTransparency=1
  emblemDotA.Visible=false;emblemDotB.Visible=false
  gemDotA.Visible=false;gemDotB.Visible=false
 end
 function ultra.startFX(repeating,dur,level)
  -- The base scheduler already animates logo trim and the home Reactor.
  -- Extra looping gradients and continuously moving dots were the source
  -- of jitter in V7.6; keep small static details instead of duplicating FX.
  homeReflection.BackgroundTransparency=1
  emblemDotA.Visible=level>=2
  emblemDotB.Visible=level>=3
  gemDotA.Visible=state.page==1 and level>=2
  gemDotB.Visible=state.page==1 and level>=3
 end

 -- Chart history is collected by the existing 2-second rate measurement.
 -- Zero GUI draws while farming. Draw all 16 bars once on mouse-wake.
 core.onRateSnapshot=function(rate,size,at)
  if not state.alive then return end
  table.insert(ultra.history,{speed=math.max(0,tonumber(rate) or 0),size=tonumber(size) or 0})
  if #ultra.history>16 then table.remove(ultra.history,1) end
 end
 function ultra.refresh(p,cap,rate,active)
  if not state.alive then return end
  if state.page~=2 or state.mode~='full' then return end
  local samples=ultra.history
  local nominal=math.max(1,tonumber((core.control.rates or {})[core.rate]) or 85)
  local maxRate=nominal
  for _,s in ipairs(samples) do maxRate=math.max(maxRate,s.speed) end
  for i,b in ipairs(rateBars) do
   local s=samples[#samples-16+i]
   if s then
    local h=math.max(3,math.min(25,math.floor(23*s.speed/maxRate+.5)))
    local goal={Position=UDim2.fromOffset(12+(i-1)*21,27-h),Size=UDim2.fromOffset(12,h)}
    b.BackgroundTransparency=state.fx==0 and .09 or .12
    b.BackgroundColor3=s.speed>nominal and palette().sub or palette().a
    if rateHeights[i]~=h then
     rateHeights[i]=h
     -- Direct positioning avoids allocating up to 16 tweens together.
     b.Position=goal.Position;b.Size=goal.Size
    end
   else
    b.Size=UDim2.fromOffset(12,2)
    b.Position=UDim2.fromOffset(12+(i-1)*21,25)
    b.BackgroundTransparency=.85
   end
  end
  if #samples<3 then
   velocityLabel.Text='กำลังเก็บข้อมูล'
   velocityLabel.TextColor3=C.muted
  else
   local before=samples[math.max(1,#samples-5)].speed
   local delta=(samples[#samples].speed-before)
   velocityLabel.Text=string.format('%+.0f /s',delta)
   velocityLabel.TextColor3=delta>=0 and palette().a or C.muted
  end
 end

 function ultra.setMode(mode)
  if state.fx==0 or (state.ux and state.ux.perfPaused) then return end
  local tm=state.motion==1 and .31 or (state.motion==3 and .15 or .23)
  if mode=='quick' then
   quickScale.Scale=qScaleFactor*.95
   tween(quickScale,{Scale=qScaleFactor},.18,Enum.EasingStyle.Quart)
  elseif mode=='full' then
   local n=shellScale.Scale
   shellScale.Scale=n*.974
   tween(shellScale,{Scale=n},tm,Enum.EasingStyle.Quart)
  elseif mode=='mini' then
   mini.Size=UDim2.fromOffset(MINI-3,MINI-3)
   tween(mini,{Size=UDim2.fromOffset(MINI,MINI)},.18,Enum.EasingStyle.Quart)
  end
 end
 function ultra.destroy()
  ultra.orbits={}
  ultra.history={}
 end

 -- No per-frame / 0.11-second Lua UI motion loop. Logo and Reactor keep
 -- GPU-friendly TweenService gradients; glints remain neatly in their sockets.
 -- Hook into V7.4 existing buttons; no new top-level navigation.
 ultra.applyTheme()
 ultra.selectPage(state.page)
 startFX()
 refresh()
 print('NKMPJ HUB V8.1.17.4 ENGINE ISOLATED | Compact UX + live size + true exit')
end
installSignatureUltraV76()
-- ============================================================================
-- V8.1.17.4 | SMART FARM BENCHMARK (OBSERVATION ONLY)
-- One optional capture inside STATS; no independent high-frequency polling loop.
-- Engine provides read-only observations from its existing 2-second CPS tick.
-- Benchmark starts only on a user's click and never changes Farm/Reset/Map.
-- ============================================================================
-- Non-critical extension: install asynchronously after the stable HUB has booted.
-- No new top-level locals, and a failure here cannot abort the stable Farm/UI boot.
task.defer(function()
 local ok,err=pcall(function()

 local panel=frame(stats,3,476,355,613,Color3.fromRGB(32,34,30),14)
 grad(panel,Color3.fromRGB(39,47,48),Color3.fromRGB(27,28,25),95)
 edge(panel,C.cyan,.74,1)
 local title=text(panel,'⏱ SMART FARM BENCHMARK',12,12,332,21,14,true,C.gold)
 local tip=text(panel,'วัดจากค่าที่เกมรายงาน • ไม่แก้ความเร็วฟาร์ม',12,37,330,17,10,false,C.muted)
 text(panel,'ระยะเวลา',12,64,95,17,11,true,C.pearl)
 local durationButtons={}
 for i,n in ipairs({15,30,60}) do
  local b=button(panel,tostring(n)..' นาที',13+(i-1)*113,85,104,30,C.raised,C.pearl,9)
  b.TextSize=11
  durationButtons[i]=b
  jewelButton(b,C.cyan)
 end
 local status=text(panel,'พร้อมทดสอบ • เปิดฟาร์มก่อนแล้วกดเริ่มบันทึก',12,124,330,19,10,true,C.mint)
 local remain=text(panel,'30:00',263,145,79,19,12,true,C.gold,Enum.TextXAlignment.Right)
 local track=frame(panel,13,168,329,6,Color3.fromRGB(53,65,68),3)
 local trackFill=frame(track,0,0,1,6,C.cyan,3)
 local barInfo=text(panel,'ยังไม่มีข้อมูล',13,147,243,18,10,false,C.muted)

 local valueLabels={}
 local function smallMetric(x,y,heading)
  local f=frame(panel,x,y,159,52,Color3.fromRGB(34,38,37),10)
  text(f,heading,9,4,142,15,10,false,C.muted)
  return text(f,'—',9,19,143,27,16,true,C.pearl)
 end
 valueLabels.gain=smallMetric(13,188,'📈 ขนาดที่เพิ่มรวม')
 valueLabels.gpm=smallMetric(182,188,'⚡ ขนาดเพิ่ม / นาที')
 valueLabels.cps=smallMetric(13,246,'🎯 CPS เฉลี่ยที่สังเกต')
 valueLabels.rounds=smallMetric(182,246,'🔄 Reset / Map')

 text(panel,'📊 ความเร็วเฉลี่ย 8 รอบล่าสุด (ขนาด/นาที)',13,306,323,18,10,true,C.gold)
 local chart=frame(panel,13,328,329,42,Color3.fromRGB(22,28,31),8)
 local bars={}
 for i=1,8 do
  local x=16+(i-1)*39
  bars[i]=frame(chart,x,37,24,2,i%2==0 and C.cyan or C.gold,4,.15)
 end
 local beginButton=button(panel,'▶ เริ่มบันทึก',13,384,200,35,C.gold,C.ink,10)
 local stopButton=button(panel,'■ สรุปก่อนเวลา',223,384,119,35,C.raised,C.pearl,10)
 beginButton.TextSize=12;stopButton.TextSize=10
 local copyButton=button(panel,'📋 คัดลอกรายงาน',13,426,158,32,C.raised,C.cyan,10)
 local saveButton=button(panel,'💾 บันทึก TXT',181,426,161,32,C.raised,C.gold,10)
 copyButton.TextSize=11;saveButton.TextSize=11
 for _,b in ipairs({beginButton,stopButton,copyButton,saveButton}) do jewelButton(b,C.edge) end
 text(panel,'รายงานผล (เลือกข้อความเพื่อคัดลอกเองได้)',13,467,326,17,10,false,C.muted)
 local preview=make('TextBox',panel,{
  Position=UDim2.fromOffset(13,489),Size=UDim2.fromOffset(329,94),
  BackgroundColor3=Color3.fromRGB(17,23,26),BorderSizePixel=0,
  Text='กดเริ่มทดสอบเพื่อเก็บข้อมูล แล้วดูรายงานที่นี่',
  TextColor3=C.pearl,PlaceholderColor3=C.muted,Font=Enum.Font.Code,
  TextSize=11,TextWrapped=false,MultiLine=true,ClearTextOnFocus=false,
  TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Top,
  TextEditable=true,ClipsDescendants=true
 })
 make('UICorner',preview,{CornerRadius=UDim.new(0,9)})
 local helper=text(panel,'ไม่มีการส่งข้อมูลออกอัตโนมัติ • ครบเวลา ฟาร์มยังทำงานต่อ',13,588,329,16,9,false,C.muted)

 local b={active=false,finished=false,selected=30,runId=0,report='',notice='',
  gain=0,cubes=0,clicks=0,resetEvents=0,mapEvents=0,
  rateIntegral=0,rateSeconds=0,tickCount=0,statRebases=0,
  targetSamples={},startTarget=0,startTurbo=false,
  rounds={},closedRounds=0,roundTimeTotal=0,roundGainTotal=0,
  bestRound=nil,current=nil,startedAt=0,expiresAt=0,lastRawGain=0,
  lastRawCubes=0,lastRawClicks=0,baselineActive=0,lastRateAt=0,
  endAt=0,endedReason='',startDate='',lastPaintKey=''}
 state.benchmark=b
 local function nonnegative(n)
  n=tonumber(n)
  if not n or n~=n or n==math.huge or n==-math.huge then return 0 end
  return math.max(0,n)
 end
 local function farmSeconds(now)
  local active=nonnegative(core.activeTotal)
  if core.on and core.activeStart then
   active=active+math.max(0,now-core.activeStart)
  end
  return math.max(0,active-b.baselineActive)
 end
 local function capture(now,rateSample)
  if not b.active then return end
  -- Core already tracks positive size changes across sells/size resets.
  -- Rebase instead of subtracting if the user clears session statistics.
  local rawGain=nonnegative(core.gainedSize)
  if rawGain>=b.lastRawGain then
   local delta=rawGain-b.lastRawGain
   b.gain=b.gain+delta
   if b.current then b.current.gain=b.current.gain+delta end
  else b.statRebases=b.statRebases+1 end
  b.lastRawGain=rawGain
  local rawCubes=nonnegative(core.gainedCubes)
  if rawCubes>=b.lastRawCubes then b.cubes=b.cubes+(rawCubes-b.lastRawCubes) end
  b.lastRawCubes=rawCubes
  local rawClicks=nonnegative(core.clickCount)
  if rawClicks>=b.lastRawClicks then b.clicks=b.clicks+(rawClicks-b.lastRawClicks) end
  b.lastRawClicks=rawClicks
  if rateSample then
   local span=math.max(0,now-b.lastRateAt)
   b.lastRateAt=now
   b.tickCount=b.tickCount+1
   local requested=(core.control and core.control.rates and core.control.rates[core.rate]) or nil
   if type(requested)=='number' and requested>0 then
    b.targetSamples[requested]=(b.targetSamples[requested] or 0)+1
   end
   if core.on and core.eat and not core.manualPaused then
    -- The tick is nominally ~2 seconds; cap delayed spikes so a long stall
    -- cannot overweight a single instantaneous CPS observation.
    local weight=math.min(span,3.5)
    b.rateIntegral=b.rateIntegral+nonnegative(core.actualRate)*weight
    b.rateSeconds=b.rateSeconds+weight
   end
  end
 end
 local function completeRound(kind,now)
  if not b.current then return end
  local secs=math.max(0,now-b.current.started)
  local gained=nonnegative(b.current.gain)
  local closed={kind=kind,seconds=secs,gain=gained,at=now,
   gpm=secs>0 and gained*60/secs or 0}
  b.closedRounds=b.closedRounds+1
  b.roundTimeTotal=b.roundTimeTotal+secs
  b.roundGainTotal=b.roundGainTotal+gained
  if secs>=1 and (not b.bestRound or closed.gpm>b.bestRound.gpm) then b.bestRound=closed end
  b.rounds[#b.rounds+1]=closed
  if #b.rounds>80 then table.remove(b.rounds,1) end
  b.current={started=now,gain=0}
 end
 local function paint()
  if not state.alive or state.mode~='full' or state.page~=2 then return end
  local now=os.clock()
  local elapsed=b.startedAt>0 and math.max(0,(b.active and now or b.endAt)-b.startedAt) or 0
  local remains=b.active and math.max(0,b.expiresAt-now) or (b.finished and 0 or b.selected*60)
  local displaySeconds=math.ceil(remains)
  local min=math.floor(displaySeconds/60)
  local sec=displaySeconds%60
  local rtxt=string.format('%02d:%02d',min,sec)
  if remain.Text~=rtxt then remain.Text=rtxt end
  local fraction=b.active and math.clamp(elapsed/math.max(1,b.selected*60),0,1)
                      or (b.finished and 1 or 0)
  local width=math.max(1,math.floor(329*fraction+.5))
  if trackFill.Size.X.Offset~=width then trackFill.Size=UDim2.fromOffset(width,6) end
  for i,buttonObj in ipairs(durationButtons) do
   local chosen=({15,30,60})[i]==b.selected
   buttonObj.BackgroundColor3=chosen and Color3.fromRGB(43,86,91) or C.raised
   buttonObj.TextColor3=chosen and C.pearl or C.muted
  end
  beginButton.Text=b.active and '● กำลังเก็บข้อมูล' or '▶ เริ่มบันทึก'
  beginButton.BackgroundColor3=b.active and Color3.fromRGB(38,88,75) or C.gold
  beginButton.TextColor3=b.active and C.pearl or C.ink
  local headerText
  if b.active then headerText='● กำลังทดสอบ • ใช้เวลา '..tostring(b.selected)..' นาที'
  elseif b.finished then headerText='✓ '..b.endedReason..' • รายงานพร้อมส่ง'
  else headerText='พร้อมทดสอบ • เปิดฟาร์มก่อนแล้วกดเริ่มบันทึก' end
  if b.notice~='' then headerText=b.notice end
  if status.Text~=headerText then status.Text=headerText end
  local activeSec=b.active and math.max(0,farmSeconds(now))
                  or (b.finished and b.finalActiveSeconds or 0)
  local perWall=elapsed>0 and b.gain*60/elapsed or 0
  local avgCps=b.rateSeconds>0 and b.rateIntegral/b.rateSeconds or 0
  valueLabels.gain.Text='+'..short(b.gain)
  valueLabels.gpm.Text=short(perWall)..'/นาที'
  valueLabels.cps.Text=b.tickCount>0 and string.format('%.1f',avgCps) or '—'
  valueLabels.rounds.Text=tostring(b.resetEvents)..' / '..tostring(b.mapEvents)
  barInfo.Text='ฟาร์มเปิด '..clock(activeSec)..' • เก็บ '..tostring(b.tickCount)..' จุด'
  -- Graph paints only while STATS is visible; last 8 completed boundaries.
  local maxGpm=1
  for i=math.max(1,#b.rounds-7),#b.rounds do
   if b.rounds[i] then maxGpm=math.max(maxGpm,b.rounds[i].gpm) end
  end
  for i,obj in ipairs(bars) do
   local index=#b.rounds-8+i
   local v=b.rounds[index]
   local h=v and math.max(2,math.floor(31*v.gpm/maxGpm+.5)) or 2
   obj.Size=UDim2.fromOffset(24,h)
   obj.Position=UDim2.fromOffset(16+(i-1)*39,39-h)
   obj.BackgroundTransparency=v and .08 or .86
  end
 end
 b.paint=paint
 -- V8.1.17.4: light real-time clock for STATS, reusing the UI pulse.
 -- Full Benchmark metrics/chart remain on the original sparse sample cadence.
 b.paintClock=function(now)
  if not state.alive or state.mode~='full' or state.page~=2 then return end
  now=now or os.clock()
  local remains=b.active and math.max(0,b.expiresAt-now)
     or (b.finished and 0 or b.selected*60)
  local displaySeconds=math.ceil(remains)
  local rtxt=string.format('%02d:%02d',math.floor(displaySeconds/60),displaySeconds%60)
  if remain.Text~=rtxt then remain.Text=rtxt end
  local fraction=b.active and math.clamp((now-b.startedAt)/math.max(1,b.selected*60),0,1)
        or (b.finished and 1 or 0)
  local width=math.max(1,math.floor(329*fraction+.5))
  if trackFill.Size.X.Offset~=width then trackFill.Size=UDim2.fromOffset(width,6) end
  if b.active then
   local caption='ฟาร์มเปิด '..clock(farmSeconds(now))..' • เก็บ '..tostring(b.tickCount)..' จุด'
   if barInfo.Text~=caption then barInfo.Text=caption end
  end
 end
 local function reportText(now,reason)
  local elapsed=math.max(0,now-b.startedAt)
  local active=math.min(elapsed,farmSeconds(now))
  local totalMinutes=math.max(.01,elapsed/60)
  local observedAvg=b.rateSeconds>0 and b.rateIntegral/b.rateSeconds or 0
  local paused=math.max(0,elapsed-active)
  local out={
   'NKMPJ HUB V8.1.17.4 | SMART FARM BENCHMARK',
   '==========================================',
   'ทดสอบเริ่ม: '..b.startDate,
   'สถานะ: '..reason,
   'ระยะเวลาที่เลือก: '..tostring(b.selected)..' นาที',
   'เวลาผ่านจริง: '..clock(elapsed),
   'เวลาระบบฟาร์มเปิด (รวมรอ Reset/Map): '..clock(active),
   'เวลาปิด/พักฟาร์มโดยประมาณ: '..clock(paused),
   '',
   'ขนาดเพิ่มสะสมที่วัดได้: +'..fmt(b.gain),
   'ขนาดเพิ่มเฉลี่ย/นาที (เวลาทั้งหมด): '..fmt(b.gain/totalMinutes),
   'ขนาดเพิ่มเฉลี่ย/นาที (เวลาฟาร์มเปิด): '..(active>0 and fmt(b.gain*60/active) or 'ไม่พร้อม'),
   'แต้มที่เพิ่มสะสม: +'..fmt(b.cubes),
   'คลิกที่เครื่องยนต์รายงานว่าส่งสำเร็จ: '..fmt(b.clicks),
   'CPS เฉลี่ยจากตัวอย่าง ~2 วิ: '..string.format('%.1f',observedAvg),
   'โหมดเริ่มทดสอบ: '..(b.startTurbo and 'ADAPTIVE TURBO' or 'ความเร็วคงที่ (Manual)'),
   'เป้าหมาย CPS ตอนเริ่ม: '..tostring(b.startTarget),
   'จำนวนตัวอย่าง CPS: '..tostring(b.tickCount),
   'จำนวน Reset: '..tostring(b.resetEvents),
   'จำนวน Map ที่ยืนยันว่าเปลี่ยน: '..tostring(b.mapEvents),
   'รอบที่สิ้นสุดด้วย Reset/Map: '..tostring(b.closedRounds),
   'เวลาเฉลี่ยต่อรอบที่จบ: '..(b.closedRounds>0 and clock(b.roundTimeTotal/b.closedRounds) or 'ยังไม่มี'),
   'ขนาดเพิ่มเฉลี่ยต่อรอบที่จบ: '..(b.closedRounds>0 and fmt(b.roundGainTotal/b.closedRounds) or 'ยังไม่มี'),
   'รอบเร็วที่สุด (ขนาด/นาที): '..(b.bestRound and fmt(b.bestRound.gpm) or 'ยังไม่มี'),
   ''
  }
  local buckets={}
  for rate,count in pairs(b.targetSamples) do buckets[#buckets+1]={rate,count} end
  table.sort(buckets,function(a,b)return a[1]<b[1]end)
  local labels={}
  for _,entry in ipairs(buckets) do
   labels[#labels+1]=tostring(entry[1])..' CPS ('..tostring(entry[2])..' ตัวอย่าง)'
  end
  out[#out+1]='เป้าหมาย CPS ที่พบ: '..(#labels>0 and table.concat(labels,', ') or 'ยังไม่มีตัวอย่าง')
  out[#out+1]=''
  out[#out+1]='ROUND DETAILS (ไม่เกิน 20 รอบล่าสุด)'
  out[#out+1]='ชนิด | เวลา | ขนาดเพิ่ม | ขนาด/นาที'
  local first=math.max(1,#b.rounds-19)
  if #b.rounds==0 then out[#out+1]='ยังไม่มีรอบที่จบ' end
  for i=first,#b.rounds do
   local r=b.rounds[i]
   out[#out+1]=string.format('%02d %s | %s | +%s | %s',
    b.closedRounds-#b.rounds+i,r.kind,clock(r.seconds),fmt(r.gain),fmt(r.gpm))
  end
  if b.current and nonnegative(b.current.gain)>0 then
   out[#out+1]='PARTIAL | '..clock(now-b.current.started)..' | +'..fmt(b.current.gain)
  end
  out[#out+1]=''
  out[#out+1]='หมายเหตุ: การเพิ่มขนาดมาจากค่า GUI เกมที่เครื่องยนต์อ่านได้ ไม่ใช่จำนวนวัตถุที่กินจริง'
  out[#out+1]='ผลรายรอบอาจคลาดเคลื่อนเล็กน้อยตามจังหวะอ่านค่า; CPS เป็นตัวอย่างของคลิกที่ส่ง ไม่ใช่ที่เซิร์ฟเวอร์รับรอง'
  if b.statRebases>0 then
   out[#out+1]='สถิติหลักถูกล้างกลางการทดสอบ '..tostring(b.statRebases)..' ครั้ง (ระบบวัดได้ปรับฐานใหม่)'
  end
  out[#out+1]='รายงานนี้บันทึกในเครื่องเท่านั้น จนกว่าจะคัดลอก/ส่งด้วยตนเอง'
  return table.concat(out,'\n')
 end
 local function finish(reason,now)
  if not b.active then return end
  now=now or os.clock()
  capture(now,false)
  b.finalActiveSeconds=farmSeconds(now)
  b.active=false;b.finished=true;b.endAt=now
  b.endedReason=reason or 'สรุปด้วยตนเอง'
  b.report=reportText(now,b.endedReason)
  b.notice=''
  preview.Text=b.report
  paint()
  if state.ux then state.ux.notify('📋 Benchmark เสร็จ • คัดลอกหรือบันทึก TXT ได้') end
 end
 b.finish=finish
 local function startTest()
  if b.active then b.notice='กำลังทดสอบอยู่ • ไป Quick HUD ได้เลย';paint();return end
  if not core.alive or not core.on or not core.eat then
   b.notice='⚠️ เปิด Auto Farm และการกินก่อนเริ่มทดสอบ';paint();return
  end
  local now=os.clock()
  b.runId=b.runId+1
  b.startedAt=now;b.expiresAt=now+b.selected*60;b.endAt=0;b.finalActiveSeconds=0
  local ok,dateString=pcall(os.date,'%Y-%m-%d %H:%M:%S')
  b.startDate=ok and tostring(dateString) or 'ไม่สามารถอ่านวันเวลาท้องถิ่น'
  b.active=true;b.finished=false;b.notice='';b.report=''
  b.gain=0;b.cubes=0;b.clicks=0;b.resetEvents=0;b.mapEvents=0
  b.rateIntegral=0;b.rateSeconds=0;b.tickCount=0;b.statRebases=0
  b.targetSamples={};b.startTurbo=not not core.turboEnabled
  b.startTarget=(core.control and core.control.rates and core.control.rates[core.rate]) or 0
  b.rounds={};b.closedRounds=0;b.roundTimeTotal=0;b.roundGainTotal=0;b.bestRound=nil
  b.current={started=now,gain=0}
  b.lastRawGain=nonnegative(core.gainedSize)
  b.lastRawCubes=nonnegative(core.gainedCubes)
  b.lastRawClicks=nonnegative(core.clickCount)
  b.baselineActive=nonnegative(core.activeTotal)+(core.on and core.activeStart and math.max(0,now-core.activeStart) or 0)
  b.lastRateAt=now
  preview.Text='กำลังเก็บข้อมูลจากจังหวะวัดเดิมทุก ~2 วินาที\nเมื่อครบเวลา Farm จะไม่หยุด\nเลือก Quick HUD แล้วปล่อยฟาร์มได้ตามปกติ'
  paint()
  local runId=b.runId
  -- One deadline callback, not an extra repeating task/polling loop.
  task.delay(b.selected*60,function()
   if state.alive and core.alive and b.active and b.runId==runId then
    finish('ครบเวลาทดสอบ',os.clock())
   end
  end)
 end
 for i,n in ipairs({15,30,60}) do
  durationButtons[i].Activated:Connect(function()
   if not state.alive then return end
   if b.active then b.notice='⏳ เปลี่ยนเวลาไม่ได้ระหว่างบันทึก' else b.selected=n;b.notice='' end
   paint()
  end)
 end
 beginButton.Activated:Connect(function()if state.alive then startTest()end end)
 stopButton.Activated:Connect(function()
  if not state.alive then return end
  if b.active then finish('สรุปก่อนกำหนด',os.clock())
  else b.notice='ยังไม่มีการทดสอบที่กำลังทำงาน';paint() end
 end)
 copyButton.Activated:Connect(function()
  if not state.alive then return end
  if b.report=='' then b.notice='ยังไม่มีรายงาน • เริ่มและสรุปผลก่อน';paint();return end
  local fn=type(setclipboard)=='function' and setclipboard or
           (type(toclipboard)=='function' and toclipboard or nil)
  if fn then
   local ok=pcall(fn,b.report)
   b.notice=ok and '✓ คัดลอกรายงานแล้ว • วางลงแชทได้เลย' or '⚠️ คัดลอกอัตโนมัติไม่ได้ • เลือกข้อความในช่อง'
  else b.notice='📋 เลือกข้อความในช่องรายงานแล้วคัดลอกเอง' end
  paint()
 end)
 saveButton.Activated:Connect(function()
  if not state.alive then return end
  if b.report=='' then b.notice='ยังไม่มีรายงาน • เริ่มและสรุปผลก่อน';paint();return end
  if type(writefile)~='function' then
   b.notice='⚠️ ตัวรันไม่รองรับบันทึก TXT • ใช้ปุ่มคัดลอก'
   paint();return
  end
  local okStamp,stamp=pcall(os.date,'%Y%m%d_%H%M%S')
  local suffix=okStamp and tostring(stamp) or tostring(math.floor(os.clock()))
  local name='NKMPJ_FARM_BENCHMARK_'..suffix..'.txt'
  local ok,err=pcall(writefile,name,b.report)
  b.notice=ok and ('✓ บันทึกไฟล์ '..name) or ('⚠️ บันทึกไม่ได้: '..tostring(err):sub(1,40))
  paint()
 end)
 -- Attach two tiny read-only observers; their invocations are protected by
 -- pcall inside the EXISTING 2s CPS tick / confirmed reset and map points.
 core.onBenchmarkTick=function(now)
  if not state.alive or not b.active then return end
  capture(now,true)
  if now>=b.expiresAt then finish('ครบเวลาทดสอบ',now) else paint() end
 end
 core.onBenchmarkBoundary=function(kind,now)
  if not state.alive or not b.active then return end
  capture(now,false)
  if kind=='RESET' then b.resetEvents=b.resetEvents+1
  elseif kind=='MAP' then b.mapEvents=b.mapEvents+1
  else return end
  completeRound(kind,now)
  paint()
 end
 paint()
 end)
 if not ok then
  warn('NKMPJ V8.1.17.4 benchmark panel failed: '..tostring(err))
  if state and state.ux and type(state.ux.notify)=='function' then
   pcall(state.ux.notify,'⚠️ Benchmark ไม่พร้อมใช้งาน • Farm เดิมยังทำงานได้')
  end
 end
end)

-- Run one read-only boot test, then restore UI-only preferences (never auto-start Farm).
task.defer(function()
 if not state.alive or not core.alive then return end
 state.ux.safe('restore-prefs',state.ux.restore)
 state.ux.safe('self-test',state.ux.selfTest)
 state.requestFullSnapshot()
end)


-- V7.9.5: Live-tested V7.9.4 click cadence retained, 120 CPS max.
-- Speed Lab removed. Faster checked sell/map transitions; no extra input loops.
-- No rewards, scanner, voting, or map auditor.
-- In-game rewards remain fully manual through the original game UI.
