@tool

extends MeshInstance3D

@export_range(3, 720) var segments = 6:
	set(value):
		segments = value
		_recreate_mesh()
	get:
		return segments

@export var height := 2:
	set(value):
		height = value
		_recreate_mesh()
	get:
		return height

@export var radius := 1:
	set(value):
		radius = value
		_recreate_mesh()
	get:
		return radius


func _enter_tree() :
	_recreate_mesh()
	
func _recreate_mesh():
	mesh = ArrayMesh.new()

	#The Cap
	var surface_array_cap = []
	surface_array_cap.resize(Mesh.ARRAY_MAX)
	
	var verts_cap = PackedVector3Array()
	var norms_cap = PackedVector3Array()
	var index_cap = PackedInt32Array()

	var alpha = 2*PI / segments
	
	verts_cap.push_back(Vector3(radius, height/2, 0))
	norms_cap.push_back(Vector3(0, 1, 0))
	
	for n in range(1, segments):
		var x = radius * cos(n * alpha)
		var z = radius * sin(n * alpha)
		
		verts_cap.push_back(Vector3(x, height/2, z))
		norms_cap.push_back(Vector3(0, 1, 0))
		
		index_cap.push_back(n-1)
		index_cap.push_back(n)
		index_cap.push_back(segments)

	verts_cap.push_back(Vector3(0, 0 ,0))
	norms_cap.push_back(Vector3(0, 1, 0))

	index_cap.push_back(segments-1)
	index_cap.push_back(0)
	index_cap.push_back(segments)
	
	surface_array_cap[Mesh.ARRAY_VERTEX] = verts_cap
	surface_array_cap[Mesh.ARRAY_NORMAL] = norms_cap
	surface_array_cap[Mesh.ARRAY_INDEX]  = index_cap
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, surface_array_cap)
	
	#the bottom
	var surface_array_bot = []
	surface_array_bot.resize(Mesh.ARRAY_MAX)
	
	var verts_bot = PackedVector3Array()
	var norms_bot = PackedVector3Array()
	var index_bot = PackedInt32Array()
	
	verts_bot.push_back(Vector3(radius, -height/2, 0))
	norms_bot.push_back(Vector3(0, -1, 0))
	
	for n in range(1, segments):
		var x = radius * cos(n * alpha)
		var z = radius * sin(n * alpha)
		
		verts_bot.push_back(Vector3(x, -height/2, z))
		norms_bot.push_back(Vector3(0, -1, 0))
		
		index_bot.push_back(n)
		index_bot.push_back(n-1)
		index_bot.push_back(segments)

	verts_bot.push_back(Vector3(0, -height / 2 ,0))
	norms_bot.push_back(Vector3(0, -1, 0))

	index_bot.push_back(0)
	index_bot.push_back(segments-1)
	index_bot.push_back(segments)
	
	surface_array_bot[Mesh.ARRAY_VERTEX] = verts_bot
	surface_array_bot[Mesh.ARRAY_NORMAL] = norms_bot
	surface_array_bot[Mesh.ARRAY_INDEX]  = index_bot
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, surface_array_bot)
	
	#sides
	var surface_array_sides = []
	surface_array_sides.resize(Mesh.ARRAY_MAX)
	var verts_sides = PackedVector3Array()
	var norms_sides = PackedVector3Array()
	var index_sides = PackedInt32Array()
	
	#cap on x axis
	verts_sides.push_back(Vector3(radius, height/2, 0))
	norms_sides.push_back(Vector3(1, 0, 0))
	#bottom on x axis
	verts_sides.push_back(Vector3(radius, -height/2, 0))
	norms_sides.push_back(Vector3(1, 0, 0))
	
	for n in range(1, segments):
		var x = cos(n * alpha)
		var z = sin(n * alpha)
		#current cap vertex
		verts_sides.push_back(Vector3(radius * x, height/2, radius * z))
		norms_sides.push_back(Vector3(x, 0, z))
		
		#current bottom vertex
		verts_sides.push_back(Vector3(radius * x, -height/2, radius * z))
		norms_sides.push_back(Vector3(x, 0, z))
		
		#first triangle
		index_sides.push_back(2 * n + 1)
		index_sides.push_back(2 * n)
		index_sides.push_back(2 * (n - 1))
		#second triangle
		index_sides.push_back(2 * n + 1)
		index_sides.push_back(2 * (n - 1))
		index_sides.push_back(2 * (n - 1) + 1)
		
	
	verts_sides.push_back(Vector3(0, -height / 2 ,0))
	norms_sides.push_back(Vector3(0, -1, 0))

	index_sides.push_back(2 * 0 + 1)
	index_sides.push_back(2 * 0)
	index_sides.push_back(2 * (segments - 1))
	#second triangle
	index_sides.push_back(2 * 0 + 1)
	index_sides.push_back(2 * (segments - 1))
	index_sides.push_back(2 * (segments - 1) + 1)
	
	surface_array_sides[Mesh.ARRAY_VERTEX] = verts_sides
	surface_array_sides[Mesh.ARRAY_NORMAL] = norms_sides
	surface_array_sides[Mesh.ARRAY_INDEX]  = index_sides
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, surface_array_sides)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
