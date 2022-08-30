-- Trooper_ModMacs Modelling Macros 
-- 3DTrooper
-- This is a collection of modifier presets/macros with custom functionality and settings
-- V 0.1   26.07.2022
-- V 0.2   05.08.2022 
-- V 0.3   21.08.2022  
-- V 0.4   27.08.2022  
-- Requirements:  For the offset option you Itoo's free "Spline Offset modifier"
-- 

try (
	destroyDialog  ModMacs
	) catch()

rollout ModMacs "ModMacs" width:128 height:587
(
	GroupBox 'grp7' "Bool" pos:[8,7] width:118 height:114 align:#left
	button 'btn_AutoGrid' "::" pos:[83,12] width:30 height:22 toolTip:"Autogrid" align:#left
	GroupBox 'grp_Width' "Spline Bool" pos:[14,32] width:104 height:64 align:#left
	button 'btn_BoolMe' "BoolMe" pos:[16,98] width:80 height:18 toolTip:"Select two objects: the cutter first, then the base object" align:#left
	spinner 'spn_Extrude' "Extrude " pos:[18,48] width:86 height:16 range:[0,1000,0.2] type:#float scale:0.1 align:#left
	checkbox 'chk_SplineChamfer' "Chamfer" pos:[16,80] width:88 height:16 enabled:true checked:false align:#left
	checkbox 'chk_SplineOffset' "" pos:[16,64] width:20 height:16 enabled:true checked:false align:#left
	spinner 'spn_SplineOffset' "Offset" pos:[35,66] width:70 height:16 range:[0.0001,50,0.2] type:#float scale:0.1 align:#left
	button 'btn_bool_browse' "B" pos:[94,98] width:28 height:18 toolTip:"Open Boolean Browser" align:#left
	GroupBox 'grp4' "Symmetry" pos:[8,128] width:112 height:72 align:#left
	button 'btn_SymMe' "SymMe" pos:[16,176] width:80 height:18 toolTip:"Add Symmetry Modifier" align:#left
	checkbox 'chk_SymMeMax' "Max" pos:[16,144] width:40 height:16 enabled:true checked:false align:#left
	checkbox 'chk_SymMeMin' "Min" pos:[72,144] width:40 height:16 enabled:true checked:false align:#left
	checkbox 'chk_SymMeRandomRot' "Random" pos:[16,160] width:88 height:16 enabled:true checked:false align:#left
	GroupBox 'grp_Chamfer' "Chamfer" pos:[8,200] width:112 height:36 align:#left
	button 'btn_Chamfer' "Chamfer" pos:[16,216] width:72 height:18 toolTip:"Add Chamfer Modifier" align:#left
	button 'btn_WeightedN' "Weighted N" pos:[16,242] width:80 height:18 toolTip:"Add Weighted Normal Modifier, roughly 1/10 of the object size" align:#left
	GroupBox 'grp10' "Sweep" pos:[8,264] width:112 height:56 align:#left
	button 'btn_Sweep' "Sweep" pos:[16,294] width:80 height:18 toolTip:"Create a Sweep Modifier with a custom profile" align:#left
	checkbox 'chk_linkprofile' "Link Profile" pos:[16,276] width:88 height:16 enabled:true checked:false align:#left
	button 'btn_opensubdiv' "OpenSubdiv" pos:[16,438] width:66 height:18 toolTip:"Add OpenSubdiV Setup" align:#left
	button 'btn_Tess' "Tess" pos:[83,438] width:34 height:18 toolTip:"Add Tesselation Modifier" align:#left
	button 'btn_AddDisplace' "AddDisplace" pos:[16,462] width:80 height:18 toolTip:"Add Displacement Modifier with a Noisemap" align:#left
	button 'btn_cc' "CC" pos:[88,216] width:28 height:18 toolTip:"Add Chamfer Modifier, small offset, roughly 1/120 of the object size" align:#left
	GroupBox 'grp_Unwrap' "Unwrap" pos:[8,486] width:112 height:42 align:#left
	button 'btn_unwrap' "Unwrap" pos:[16,500] width:50 height:18 toolTip:"Basic Unwrap, opens the Editor Window" align:#left
	button 'btn_unwrap_ch2' "UwCh2" pos:[72,500] width:40 height:18 toolTip:"Basic Unwrap Channel 2" align:#left
	GroupBox 'grp_materials' "Materials" pos:[8,520] width:112 height:42 align:#left
	button 'btn_material' "Edge Mat" pos:[68,536] width:48 height:18 toolTip:"Creates a basic worn edges material using Arnold Shaders" align:#left
	button 'btn_materialB' "PBR Mat" pos:[16,536] width:48 height:18 toolTip:"Creates a basic PBR material" align:#left
	button 'btn_Toolbox' "Toolbox" pos:[16,564] width:44 height:18 toolTip:"Open Transform Toolbox" align:#left
	-- button 'btn_BackupToLayer' "BackupLay" pos:[64,564] width:56 height:18 toolTip:"Backup selection to Backup Layer" align:#left
	button 'btn_Retopo' "Retopo" pos:[16,366] width:48 height:18 toolTip:"Add Retopo Modifier" align:#left
	button 'btn_Quadify' "Quadi" pos:[70,366] width:48 height:18 toolTip:"Add Quadify Modifier" align:#left
	button 'btn_Cloth' "Cloth" pos:[16,410] width:56 height:18 toolTip:"Add mCloth and pin selected Verts from Stack" align:#left
	button 'btn_weld' "Weld" pos:[16,342] width:48 height:18 toolTip:"Add Vertex Weld Modifier" align:#left
	button 'btn_meshclean' "Cleaner" pos:[70,342] width:48 height:18 toolTip:"Add Mesh Cleaner" align:#left
	GroupBox 'grp27' "Clean/Remesh" pos:[8,328] width:112 height:62 align:#left
	GroupBox 'grp_cloth' "Cloth" pos:[8,393] width:112 height:42 align:#left
	
	
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
				addmodifier i (Spline_Chamfer ())
				i.modifiers[#Spline_Chamfer].depth = 0
				i.modifiers[#Spline_Chamfer].amount = chamfamount
			)
		else		
			(
				addmodifier i (Chamfer ())
				i.modifiers[#Chamfer].segments = 1
				i.modifiers[#Chamfer].amount = chamfamount
				i.modifiers[#Chamfer].depth = 0	
			)
	)

-- Buttons
	
	on TDT_ModifierMacros open do
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
		
	
		If (SuperClassOf selectedObjA == shape and SuperClassOf selectedObjB == shape) then
			(
				print "select a geometry object"
			)
			else
		if selection.count > 2 or selection.count < 2 then
			(
				clearSelection()
				print "select two objects"
			)
		else
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
			select selectedObjB
			max modify mode
			redrawViews
		)	
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
					i.modifiers[#Symmetry].PlanarZ = off	
						
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
		if ($ != undefined) do
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
		addmodifier selection (Weighted_Normals ())
			for i in selection do
			(
				i.modifiers[#Weighted_Normals].useHardEdgeAngle = on
			)
			)
		)
	on btn_Sweep pressed do
	(	
		if ($ != undefined) do
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
	on btn_opensubdiv pressed do
	(	
		if ($ != undefined) do
		(
			addmodifier selection (CreaseSet ())
			addmodifier selection (OpenSubdiv ())
			for i in selection do
			(
				i.modifiers[#OpenSubdiv].iterations = 2
				i.modifiers[#OpenSubdiv].renderIterations = 4
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
-- 				cm.edit()	
			)
		)
	)
	on btn_unwrap_ch2 pressed do
	(	
		if (selection != undefined and selection.count == 1) do
			(
				addmodifier $ (Unwrap_UVW Name:"UVW_CH2") 
				cm = modPanel.getCurrentObject() 
-- 				cm.setIgnoreBackFaceCull off
-- 				cm.edit()				
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
	on btn_materialB pressed do
	(
	for i in selection do
		(
			objname=i.name 
			i.material = PBRMetalRough name:("M_" + objname) Basecolor:(color 5 5 5) Roughness:(0.95) Metalness:(1) showInViewport:true n		
		)
	)

	on btn_Toolbox pressed do
	(
		macros.run "PolyTools" "TransformTools"
		)
		
	on btn_BackupToLayer pressed do
	(
	--not here yet
	)
	on btn_Retopo pressed do
	(
		If (RetopologyComponent() != undefined and $ != undefined) then 
		(				
			addmodifier selection (RetopologyComponent ())
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
				addmodifier selection (Vertex_Weld ())
				for i in selection do
				(
					i.modifiers[#Vertex_Weld].Threshold = 0.01 
				)
			)
		)
	on btn_meshclean pressed do
	(
		if ($ != undefined) do
			(
				addmodifier selection (MeshCleaner ())
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
)

createDialog ModMacs
SetDialogPos ModMacs [1780,180]
	

