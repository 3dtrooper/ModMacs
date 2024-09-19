-- Trooper_ModMacs Modelling Macros 
-- 3DTrooper
-- This is a collection of modifier presets/macros with custom functionality and settings
-- v 0.5   	27.09.2022 Minor fixes,Added Radial Symmetry with custom reference object
-- v 0.6   	02.02.2024 Updated to work with the new boolean modifier, wip:a simple recteangular or circular stamp object can added to the booleans, crease set modifier adds an initial set, undo added in various places
-- v.0.7	20.07.2024 UI Is Dockable now, Array Suport, Fixes. 	
-- Requirements:  For the offset option you need Itoo's free "Spline Offset modifier"  www.itoosoft.com 

try(cui.UnRegisterDialogBar ModMacs) catch()
try (destroyDialog  ModMacs) catch()	
if ModMacs != undefined then
		(
			destroyDialog ModMacs
		)	

size = Box3  -- [0,0,0] [1,1,1]	
global stampDepth = 2
global stamp 	
global boxyes
rollout ModMacs "ModMacs" width:128 height:836
(
	GroupBox 'grp7' "Bool" pos:[8,8] width:118 height:232 align:#left
	button 'btnFloat' "F" pos:[90, 8] width:32 height:12 toolTip:"Float Dialog"
    button 'btnDockLeft' "<" pos:[90, 20] width:16 height:12 toolTip:"Dock Left"
    button 'btnDockRight' ">" pos:[106, 20] width:16 height:12 toolTip:"Dock Right"
	button 'btn_AutoGrid' "::" pos:[48,8] width:30 height:18 toolTip:"Autogrid" align:#left
	GroupBox 'grp_Width' "Spline Bool" pos:[14,32] width:104 height:68 align:#left
	button 'btn_BoolMe' "BoolMe" pos:[16,216] width:78 height:18 toolTip:"Select two objects: the cutter first, then the base object" align:#left
	spinner 'spn_Extrude' "Extrude " pos:[18,48] width:90 height:16 range:[0,1000,0.5] type:#float scale:0.1 align:#left
	checkbox 'chk_SplineChamfer' "Chamfer" pos:[16,82] width:88 height:16 enabled:true checked:false align:#left
	checkbox 'chk_SplineOffset' "" pos:[16,66] width:20 height:16 enabled:true checked:false align:#left
	spinner 'spn_SplineOffset' "Offset" pos:[35,66] width:70 height:16 range:[0.0001,50,0.2] type:#float scale:0.1 align:#left
	button 'btn_bool_browse' "B" pos:[92,216] width:28 height:18 toolTip:"Open Boolean Browser" align:#left
	GroupBox 'grp4' "Symmetry" pos:[8,296] width:116 height:71 align:#left
	button 'btn_SymMe' "SymMe" pos:[16,345] width:80 height:18 toolTip:"Add Symmetry Modifier" align:#left
	checkbox 'chk_SymMeMax' "Max" pos:[16,313] width:40 height:16 enabled:true checked:false align:#left
	checkbox 'chk_SymMeMin' "Min" pos:[72,313] width:40 height:16 enabled:true checked:false align:#left
	checkbox 'chk_SymMeRandomRot' "Random" pos:[16,329] width:88 height:16 enabled:true checked:false align:#left
	GroupBox 'grp_Chamfer' "Chamfer" pos:[8,437] width:112 height:36 align:#left
	button 'btn_Chamfer' "Chamfer" pos:[16,453] width:48 height:18 toolTip:"Add Chamfer Modifier" align:#left
	button 'btn_cc' "Cham/120" pos:[64,453] width:54 height:18 toolTip:"Add Chamfer Modifier, small offset, roughly 1/120 of the object size" align:#left
	button 'btn_WeightedN' "Weighted N" pos:[16,479] width:80 height:18 toolTip:"Add Weighted Normal Modifier, by angle 30" align:#left
	GroupBox 'grp10' "Sweep" pos:[8,501] width:112 height:56 align:#left
	button 'btn_Sweep' "Sweep" pos:[16,531] width:80 height:18 toolTip:"Create a Sweep Modifier with a custom profile" align:#left
	checkbox 'chk_linkprofile' "Link Profile" pos:[16,513] width:88 height:16 enabled:true checked:false align:#left
	button 'btn_opensubdiv' "OpenSubdiv" pos:[16,675] width:66 height:18 toolTip:"Add OpenSubdiV Setup" align:#left
	button 'btn_Tess' "Tess" pos:[83,675] width:34 height:18 toolTip:"Add Tesselation Modifier" align:#left
	button 'btn_AddDisplace' "AddDisplace" pos:[16,699] width:80 height:18 toolTip:"Add Displacement Modifier with a Noisemap" align:#left
	GroupBox 'grp_Unwrap' "Unwrap" pos:[8,723] width:112 height:42 align:#left
	button 'btn_unwrap' "Unwrap" pos:[16,737] width:50 height:18 toolTip:"Basic Unwrap, opens the Editor Window" align:#left
	button 'btn_unwrap_ch2' "UwCh2" pos:[72,737] width:40 height:18 toolTip:"Basic Unwrap Channel 2" align:#left
	GroupBox 'grp_materials' "Materials" pos:[8,757] width:112 height:42 align:#left
	button 'btn_material' "Edge Mat" pos:[68,773] width:48 height:18 toolTip:"Creates a basic worn edges material using Arnold Shaders" align:#left
	button 'btn_materialB' "PBR Mat" pos:[16,773] width:48 height:18 toolTip:"Creates a basic PBR material" align:#left
	button 'btn_Toolbox' "Toolbox" pos:[16,801] width:44 height:18 toolTip:"Open Transform Toolbox" align:#left
	button 'btn_Retopo' "Retopo" pos:[16,603] width:48 height:18 toolTip:"Add Retopo Modifier" align:#left
	button 'btn_Quadify' "Quadify" pos:[70,603] width:48 height:18 toolTip:"Add Quadify Modifier" align:#left
	button 'btn_Cloth' "Cloth" pos:[16,647] width:56 height:18 toolTip:"Add mCloth and pin selected Verts from Stack" align:#left
	button 'btn_weld' "Weld" pos:[16,579] width:48 height:18 toolTip:"Add Vertex Weld Modifier" align:#left
	button 'btn_meshclean' "Cleaner" pos:[70,579] width:48 height:18 toolTip:"Add Mesh Cleaner" align:#left
	GroupBox 'grp27' "Clean/Remesh" pos:[8,565] width:112 height:62 align:#left
	GroupBox 'grp_cloth' "Cloth" pos:[8,630] width:112 height:42 align:#left
	GroupBox 'grp_Radial' "Radial" pos:[8,375] width:112 height:60 align:#left
	checkbox 'chk_RadialRef' "Ref" pos:[16,391] width:40 height:16 enabled:true checked:true align:#left
	checkbox 'chk_RadialTransform' "Link" pos:[72,391] width:40 height:16 enabled:true checked:true align:#left
	button 'btn_RadialSym' "RadMe" pos:[16,411] width:56 height:18 toolTip:"Add Radial Symmetry Modifier, optional with a custom reference object" align:#left
	GroupBox 'grp_stamp' "Stamp" pos:[14,104] width:104 height:104 align:#left
	checkbox 'chk_usestamp' "Stamp" pos:[16,120] width:80 height:16 align:#left toolTip:"Stamp the bool object in" enabled:true checked:false
	spinner 'spn_stampoffset' "Offset" pos:[18,142] width:73 height:16 align:#left toolTip:"Stamp Offset" range:[0.001,500,0.001] type:#float scale:0.001 
	checkbox 'chk_rectengular' "Rec" pos:[16,168] width:50 height:16 align:#left toolTip:"Rectangular Stamp" enabled:true checked:true
	checkbox 'chk_cricular' "Circ" pos:[64,168] width:50 height:16 align:#left toolTip:"Circular Stamp" enabled:true checked:false
	checkbox 'chk_arrayhandle' "Array stamp" pos:[16,186] width:80 height:16 align:#left enabled:true checked:false toolTip:"Use array to stamp" 
	GroupBox 'grp_array' "Array" pos:[8,248] width:116 height:47 align:#left
	button 'btn_arraygrid' "Grid" pos:[16,266] width:30 height:18 toolTip:"Centered Grit Array" align:#left
	button 'btn_arraycricular' "Circular" pos:[45,266] width:38 height:18 toolTip:"Centered Cricular Array" align:#left
	button 'btn_arraySpline' "Spline" pos:[84,266] width:36 height:18 toolTip:"Spline Array" align:#left
	
-- Functions
	fn CheckShape objA objB = (
		
		If (SuperClassOf objA == shape) then
		   (
					If (chk_SplineOffset.state == true and SplineOffset() != undefined) then 
						(	
						ammountOffset = (spn_SplineOffset.value)	
						addmodifier objA (SplineOffset ())
						ammountOffset = (spn_SplineOffset.value)	
						objA.modifiers[#SplineOffset].offset = ammountOffset
							
						If (ClassOf objA.baseObject == Line or ClassOf objA.baseObject == Arc) then 	
							( 								
							objA.modifiers[#SplineOffset].endtype = 3	
							objA.modifiers[#SplineOffset].keeporiginal = off
 							)
						)
					else
					(
						print "this function uses itoo software's free splineoffset modifier: www.itoosoft.com "
					)
					
					If chk_SplineChamfer.state == true do
						(	
						addmodifier objA (Spline_Chamfer ())
						)
						
					ammountExstr = spn_Extrude.value
					in coordsys local move objA [0,0,(0.001)] 
					addmodifier objA (Extrude ())
					objA.modifiers[#Extrude].amount = (-ammountExstr)
					objA.modifiers[#Extrude].mapcoords = on
					print "CheckShape"	
			)
	)

	fn boolSubstract objA objB = (
		bool = objB
		bool.AppendOperand bool objA false
		
		booloperands = bool.GetNumOperands()
		bool.SetOperationType booloperands #subtraction 
	)
	
	fn ShapeSteps stepsA = (
		$.steps = stepsA
	)
	
	fn chamferMe chamfamount chobj = (
		i = chobj
		If (SuperClassOf i == shape) then
		   ( 	
				undo on(
				addmodifier i (Spline_Chamfer ())
				i.modifiers[#Spline_Chamfer].depth = 0
				i.modifiers[#Spline_Chamfer].amount = chamfamount
				)
			)
		else		
			(
				undo on(
				addmodifier i (Chamfer ())
				i.modifiers[#Chamfer].segments = 1
				i.modifiers[#Chamfer].amount = chamfamount
				i.modifiers[#Chamfer].depth = 0	
				)
			)
	)
	fn createAdditionaloObjs size selectedObjA selectedObjB = (			
		if (boxyes == true) then
				(
					currentObjAT = selectedObjA.transform
					in coordsys (transmatrix selectedObjA.transform.pos)
					selectedObjA.rotation = (eulerangles 0 0 0)
					stamp = Box width:(size.x+(size.x*stampOffset)) length:(size.y+(size.y*stampOffset)) height:(size.z*(-stampDepth)) name:(nodepname + "_stamp") --transform:selectedObjA.transform
				)
				else if (boxyes != true) then
				(
					currentObjAT = selectedObjA.transform
					in coordsys (transmatrix selectedObjA.transform.pos)
					selectedObjA.rotation = (eulerangles 0 0 0)
					stamp = Cylinder radius:(abs((size.x+((size.x*stampOffset)/2)))) height:((size.y)*2) sides:32 name:(nodepname + "_stamp") --transform:selectedObjA.transform
				)
				
			if (selectedObjA.modifiers[Arraymodifier] != undefined) then
				(				
				if (chk_arrayhandle == false) then
					(		
						mmms = selectedObjA.modifiers[Arraymodifier] 
						addModifier stamp mmms
					)
				)
			theHelper = Point Name:(nodepname + "_Helper")  --  create helper
			theHelper.pos= selectedObjA.pos
			selectedObjA.parent = theHelper
			theHelper.parent = selectedObjB
			
			stamp.transform = theHelper.transform
			stamp.parent = theHelper	

			theHelper.transform = currentObjAT
	)
	
	fn addBools selectedObjB selectedObjA = (
		selectedObjB.modifiers[#Boolean].useLiveReference = on
		selectedObjB.modifiers[#Boolean].AppendOperand #single operandNode:stamp operationType:#subtraction		
	    selectedObjB.modifiers[#Boolean].AppendOperand #single operandNode:selectedObjA operationType:#union
	    selectedObjB.modifiers[#Boolean].useOperandMaterial = off
	)
			
	fn boolIt selectedObjA selectedObjB = (				
		select selectedObjB
		cm = modPanel.getCurrentObject() 
		if classOf cm != BooleanMod then
			(
				max modify mode
				modPanel.addModToSelection (BooleanMod ())
				addBools selectedObjB selectedObjA
			)
			else
			(	
				addBools selectedObjB selectedObjA
			)
		)
	
-- Buttons
	
	on btnDockLeft pressed do (
        try(cui.UnRegisterDialogBar ModMacs) catch()
        createDialog ModMacs
        cui.RegisterDialogBar ModMacs
        cui.DockDialogBar ModMacs #cui_dock_left
    )

    on btnDockRight pressed do (
        try(cui.UnRegisterDialogBar ModMacs) catch()
        createDialog ModMacs 
        cui.RegisterDialogBar ModMacs
        cui.DockDialogBar ModMacs #cui_dock_right
    )

    on btnFloat pressed do (
        try(cui.UnRegisterDialogBar ModMacs) catch()
        createDialog ModMacs
		SetDialogSize ModMacs [128,836]
    )	
		
	on ModMacs open do
	(
		maxOps.autoGrid = true
	)
	on btn_AutoGrid pressed do
	(
		if maxOps.autoGrid == false then 
			(   
			maxOps.autoGrid = true
			print "Autogrid is on"
			)
		else 
			(			
			maxOps.autoGrid = false	
			print "Autogrid is off"
			)
	)
	on btn_BoolMe pressed do
	(	
		objectSel = selection as array
		selectedObjA = objectSel[1]
		selectedObjB = objectSel[2]
		ammountExstr = (spn_Extrude.value)
		ammountOffset = (spn_SplineOffset.value)	
		bool = selectedObjB
		
		global nodepos = selectedObjA.pos
		global nodepname = selectedObjA.name
		global ObjATf = selectedObjA.transform

		global stampOffset = spn_stampoffset.value
		boxyes = chk_rectengular.state 
		print boxyes
		
		If (SuperClassOf selectedObjA == shape and SuperClassOf selectedObjB == shape) then
			(
				print "select a geometry object"
			)
		else
		If selection.count > 2 or selection.count < 2 then
			(
				clearSelection()
				print "select two objects" 
			)
		else
		If (SuperClassOf selectedObjA == GeometryClass and SuperClassOf selectedObjB == shape) then
			(
				selectedObjA = objectSel[2]
				selectedObjB = objectSel[1]
			)
		else
		(
			If (BooleanMod () == undefined) then	
				(
					If (ClassOf selectedObjB.baseObject == Boolean3) then
					(
						CheckShape selectedObjA selectedObjB
						boolSubstract selectedObjA selectedObjB
					)
					else
					(
						select selectedObjB
						StartObjectCreation Boolean3 
						CheckShape selectedObjA selectedObjB
						boolSubstract selectedObjA selectedObjB
					)
				)
				
				else --2024 Booleans
				(
					If (chk_usestamp.state == true) then 
					(	
					undo on(
						if (selectedObjA.modifiers[Arraymodifier] == undefined) then
							(
								bbVal = selectedObjA.boundingBox
								minBOX = bbVal.min
								maxBOX = bbVal.max
								size = minBOX - maxBOX 
							)
						else
							(------ Handle Array
								mmms = selectedObjA.modifiers[Arraymodifier]
								mmms.enabled = false
								bbVal = selectedObjA.boundingBox
								mmms.enabled = true
								minBOX = bbVal.min
								maxBOX = bbVal.max
								size = minBOX - maxBOX 

								print "---------------------------------------"
							)
						CheckShape selectedObjA selectedObjB
						createAdditionaloObjs size selectedObjA selectedObjB
						boolIt selectedObjA selectedObjB							
						)
					)
					else	
					(	
						undo on(
							CheckShape selectedObjA selectedObjB
							select selectedObjB
							max modify mode
							cm = modPanel.getCurrentObject() 
							if classOf cm != BooleanMod then
								(
								modPanel.addModToSelection (BooleanMod ())
								selectedObjB.modifiers[#Boolean].AppendOperand #single operandNode:selectedObjA operationType:#subtraction
								)
								else
								(
								selectedObjB.modifiers[#Boolean].AppendOperand #single operandNode:selectedObjA operationType:#subtraction
								)
							)
						)
				)

			select selectedObjB
			max modify mode
			redrawViews	
		)

	)
	
	on chk_rectengular changed theState do
		(
			chk_cricular.state = false
			)
	on chk_cricular changed theState do
		(
			chk_rectengular.state = false
			)
	
	on btn_bool_browse pressed do
	(
		bbman = BooleanExplorerManager.OpenBooleanExplorer ()
	)
	on btn_SymMe pressed do
	(	
		if ($ != undefined) do
		(
			for i in selection do
			(
				bbVal = i.boundingBox	
				minBOX = bbVal.min
				maxBOX = bbVal.max
				if (SuperClassOf i == shape) then
				(
					addmodifier i (SplineMirror ())
					)
				else
				(		
					addmodifier i (symmetry ())
					i.modifiers[#Symmetry].PlanarX = on
					i.modifiers[#Symmetry].PlanarZ = off	
					i.modifiers[#Symmetry].PlanarY = off	
						
					If chk_SymMeMin.state and chk_SymMeMax.state == false do 
						(
							i.modifiers[#Symmetry].mirror.position = [0,0,0]
						)
					If chk_SymMeMin.state == true do
						(
						obj=i 
						objTM=obj.objecttransform
						modTM=getModContextTM obj obj.symmetry
						obj.symmetry.mirror.position * (inverse modTM) * objTM
						obj.symmetry.mirror.position = minBOX * modTM * (inverse objTM)
						)
						
					If chk_SymMeMax.state == true do
						(
						i.modifiers[#Symmetry].PlanarFlipX = on
						obj=i		
						objTM=obj.objecttransform
						modTM=getModContextTM obj obj.symmetry
						obj.symmetry.mirror.position * (inverse modTM) * objTM
						obj.symmetry.mirror.position = maxBOX * modTM * (inverse objTM)
						)
					
					If chk_SymMeRandomRot.state == true do
					(
						i.modifiers[#Symmetry].mirror.rotation =  (eulerAngles (random 1 360) (random 1 360)  (random 1 360) ) as quat
					)
				)
				redrawViews
			)
		)
	)
	on chk_SymMeMax changed theState do
	(
		chk_SymMeMin.state = false
		)
	on chk_SymMeMin changed theState do
	(
		chk_SymMeMax.state = false
		)
	on btn_Chamfer pressed do
	(	
		if ($ != undefined) do
		(
			for i in selection do
			(
				bbVal = i.boundingBox	
				minBOX = bbVal.min
				maxBOX = bbVal.max
				size = minBOX - maxBOX
				chamVal = size[1]/10
				val = abs chamVal
				chamferMe val i	 
				)
			)
		)
	on btn_cc pressed do
	(	
		if ($ != undefined ) do
		(
			for i in selection do
			(
				bbVal = i.boundingBox	
				minBOX = bbVal.min
				maxBOX = bbVal.max
				size = minBOX - maxBOX
				chamVal = size[1]/120
				val = abs chamVal
				chamferMe val i			
				)
			)
		)
	on btn_WeightedN pressed do
	(	
		if ($ != undefined) do
		(
			for i in selection do
			(
				addmodifier i (Weighted_Normals ())
				i.modifiers[#Weighted_Normals].useHardEdgeAngle = on
			)
			)
		)
	on btn_Sweep pressed do
	(	
		undo on(
		if ($ != undefined) do
				(
				If (SuperClassOf $ == shape) do	
					(
					profileSplineSize = 3 
						-- create custom spline 
						sp = splineShape name: "SweepProfile"
						addnewSpline sp
						addKnot sp 1 #corner #line [profileSplineSize,profileSplineSize,0]
						addKnot sp 1 #corner #line [-profileSplineSize,profileSplineSize,0]
						addKnot sp 1 #corner #line [-profileSplineSize,0,0]
						addKnot sp 1 #corner #line [profileSplineSize,0,0]
						close sp 1
						updateShape sp
						
					theShape=#()
					for obj in selection do (if superclassof obj == shape then append theShape obj)										
					posA = theShape[1].position
						
					if superclassof theShape[1] == shape then(
						theMod = sweep()
						addModifier theShape theMod--add the sweep
							for i in theShape do
							(	
								i.modifiers[#Sweep].shapes[1] = sp								
								i.modifiers[#Sweep].customShape = 1
								i.modifiers[#Sweep].GenerateMappingCoords = on	
								)
						)	
			
					If chk_linkprofile.state == true do
							(	
							sp.parent = theShape[1]
							updateShape sp
							select sp	
							)
					select sp
					rotate $ (angleaxis 90 [1,0,0])	
					sp.position = (posA + [0,0,0.1])		
					)
			)
		)
	)
	on btn_opensubdiv pressed do
	(	
		if ($ != undefined) do
		(
			addmodifier selection (CreaseSet ())
			for i in selection do
			(
				subobjectLevel = 2
				i.modifiers[#CreaseSet].DoSelectByAngle()
				i.modifiers[#CreaseSet].CreateSet "Set 1" 
			)
			addmodifier selection (OpenSubdiv ())
			for i in selection do
			(
				i.modifiers[#OpenSubdiv].iterations = 2
				i.modifiers[#OpenSubdiv].renderIterations = 4
			)
		)
	)
	on btn_Tess pressed do
	(	
		if ($ != undefined) do
		(
			addmodifier selection (tessellate ())
			for i in selection do
			(
			i.modifiers[#Tessellate].faceType = 1
			i.modifiers[#Tessellate].iterations = 2
			i.modifiers[#Tessellate].tension = 0
			)
			
		)
	)
	on btn_AddDisplace pressed do
	(	
		if ($ != undefined) do
		(
			addmodifier selection (Displace ())
			for i in selection do
			(
				tm = noise()
				tm.size = 10
				tm.name = "DisplNoiseMap"
				i.modifiers[#Displace].useMap = on
				i.modifiers[#Displace].strength = 1
				i.modifiers[#Displace].map = tm 
				)
			)
		)
	on btn_unwrap pressed do
	(	
		if (selection != undefined and selection.count == 1) do
			(
			max modify mode
			modifs = for m in $.modifiers where classof m == Unwrap_UVW collect m 
			if modifs.count == 0 then
				(
				addmodifier $ (Unwrap_UVW Name:"UVW_CH1") 
				cm = modPanel.getCurrentObject() 
	--				cm.setIgnoreBackFaceCull off
	-- 				cm.edit()				
				cm.flattenMap 45 #() 0.01 true 0 true true
				cm.quick_map_preview = off
				cm.unwrap5.setShowMapSeams off
				cm.unwrap5.setPeltAlwaysShowSeams off
				cm.pack 3 0.002 true false false 	
			)
			else
				(
				cm = modPanel.setCurrentObject $.modifiers[Unwrap_UVW]	--accsses the first modifier 	
				cm = modPanel.getCurrentObject() 	
			)
		)
	)
	on btn_unwrap_ch2 pressed do
	(	
		if (selection != undefined and selection.count == 1) do
			(
				max modify mode
				addmodifier $ (Unwrap_UVW Name:"UVW_CH2") 
				cm = modPanel.getCurrentObject() 				
				cm.flattenMap 45 #() 0.01 true 0 true true
				cm.quick_map_preview = off
				cm.unwrap5.setShowMapSeams off
				cm.unwrap5.setPeltAlwaysShowSeams off
				cm.pack 3 0.002 true false false 
				cm.unwrap.setMapChannel 2
			)
	)
	on btn_material pressed do
	(
		undo on(
		for i in selection do
		(	
		--Generate MultiMaterial
			amount = 1	
			objname = i.name 	
			mat = Multimaterial numsubs:amount name:objname 
	
				for a=1 to amount do
				(	
					suffB = a as string	
					tm = ai_noise()
					tm.octaves = 3
					tm.name = "Curvature_Edge_Noise" + suffB
					curvaMap = ai_curvature()
					curvaMap.radius_shader = tm
					curvaMix = 	ai_mix_shader()	
					curvaMix.mix_shader = curvaMap
					mat.names[a] = ("M_" + suffB)
					newphysA = PBRMetalRough name:("M_" + objname + "_" + suffB) Basecolor:(color 5 5 5) Roughness:(0.95) Metalness:(1) showInViewport:true n	
					newphysB = PBRMetalRough name:("M_" + objname + "_Edge_" + suffB) Basecolor:(color 10 10 10) Roughness:(0.3) Metalness:(0.95) showInViewport:true n
					curvaMix.shader1 = newphysA
					curvaMix.shader2 = newphysB	
					mat.material[a] = curvaMix
				)
			i.material = mat
			print mat.numsubs
		)
	)
	)
	on btn_materialB pressed do
	(
	for i in selection do (
		undo on(
				objname=i.name 
				i.material = PBRMetalRough name:("M_" + objname) Basecolor:(color 5 5 5) Roughness:(0.95) Metalness:(1) showInViewport:true n		
			)
		)
	)
	on btn_Toolbox pressed do
	(
		macros.run "PolyTools" "TransformTools"
		)
	on btn_Retopo pressed do
	(
		undo on(
		If (RetopologyComponent() != undefined and $ != undefined) then 
		(				
			addmodifier selection (RetopologyComponent ())
			cm = modPanel.getCurrentObject() 		
			cm.numFacesTarget = 2000				
			)
		)
		)
	on btn_Quadify pressed do
	(
		if ($ != undefined) do
		(
		addmodifier selection (Quadify_Mesh ())
		redrawViews
		)	
	)
	on btn_Cloth pressed do
	(
		if ($ != undefined and selection.count == 1) do
		(
		objSel = $
		If (ClassOf $ == PolyMeshObject or ClassOf $ == Editable_Poly) then
			(
				If (ClassOf $ == Editable_Poly) then
				(
					addmodifier $ (Edit_Poly ())
					)
				else
				(
				vertselection = $.modifiers[#Edit_Poly].GetSelection #Vertex
				addmodifier $ (mCloth ())
				$.modifiers[#mCloth].selectVertices vertselection
				$.modifiers[#mCloth].makePointGroup vertselection "ClothP"	
				$.modifiers[#mCloth].makeConstraint "ClothP" "Pin" objSel	
				)
					)
					else
					(
	-- 				addmodifier $ (Edit_Poly ())
				addmodifier $ (mCloth ())
	
				)
		$.modifiers[#mCloth].pressure = 1.4
		$.modifiers[#mCloth].do_pressure = on
		$.modifiers[#mCloth].gravity = 0.6
		$.modifiers[#mCloth].thickness = 1
		$.modifiers[#mCloth].enablelivedrag = true
		)			
	)
	on btn_weld pressed do
	(
		if ($ != undefined) do
			(
				for i in selection do
				(
					addmodifier i (Vertex_Weld ())
					i.modifiers[#Vertex_Weld].Threshold = 0.01 
				)
			)
		)
	on btn_meshclean pressed do
	(
		if ($ != undefined and superClassOf $ == GeometryClass) do
			(
				addmodifier selection (MeshCleaner ())
			)
		)
	on btn_RadialSym pressed do
	(	
		if ($ != undefined) do
			(
				undo on(
				for i in selection do
					(
						bbVal = i.boundingBox	
						minBOX = bbVal.min
						maxBOX = bbVal.max
						addmodifier i (symmetry Name:"SymRad")
						i.modifiers[#SymRad].PlanarZ = off 
						i.modifiers[#SymRad].PlanarY = on
						i.modifiers[#SymRad].SymmetryFormat = 1
						i.modifiers[#SymRad].RadialCount = 4
						i.modifiers[#SymRad].RadialMirror = on
							
						If chk_RadialRef.state == true then
						(					
							nameObj = i.name
							transObj = i.transform
							theHelper = Point Name:(nameObj + "_Sym")
							theHelper.pos = i.pos
	
						If chk_RadialTransform.state == true then
							(	
								theHelper.transform = transObj
								i.parent = theHelper
							)
						i.modifiers[#SymRad].ReferenceObject = theHelper							
	-- 					in coordsys local move i [0,(maxBOX[1]),0]
					)			
					)
				)
			)
		)
	on btn_arraygrid pressed do
	(
			if ($ != undefined and Arraymodifier () != undefined) do
			(
				undo on(
				for i in selection do
					(
					addmodifier i (Arraymodifier())
					i.modifiers[#Array].center = on
					i.modifiers[#Array].county = 2	
					i.modifiers[#Array].offsetY = 2
					i.modifiers[#Array].countx = 2
					i.modifiers[#Array].offsetx = 2
					)
				)
			)
		)	
	on btn_arraycricular pressed do
	(	
				if ($ != undefined and Arraymodifier () != undefined) do
			(
				undo on(
				for i in selection do
					(
					addmodifier i (Arraymodifier())	
					i.modifiers[#Array].type = 1 --radial
					i.modifiers[#Array].arrayRadius = 25.9
					i.modifiers[#Array].center = off
					i.modifiers[#Array].RadialCount = 6
					)
				)
			)
	
	)
	on btn_arraySpline pressed do
	(	
		objectSel = selection as array
		selectedObjA = objectSel[1]
		selectedObjB = objectSel[2]
		If selection.count > 2 or selection.count < 2 then
			(
				clearSelection()
				print "select two objects" 
			)
		else
		if (Arraymodifier () != undefined) do
			(
				undo on(
					If SuperClassOf selectedObjB == GeometryClass do
						(
							print "................"
							objectSel = selection as array
							selectedObjA = objectSel[2]
							selectedObjB = objectSel[1]
						)
					addmodifier selectedObjA (Arraymodifier())	
					selectedObjA.modifiers[#Array].type = 2 -- spline
					selectedObjA.modifiers[#Array].referenceSpline = selectedObjB
					selectedObjA.modifiers[#Array].splinePercentType = 1 --loop
					selectedObjA.modifiers[#Array].countX = 16
				)
			)
	)
)

createDialog ModMacs
SetDialogPos ModMacs [1780,180]
	

