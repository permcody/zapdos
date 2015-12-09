[Mesh]
  type = GeneratedMesh
  dim = 1
  nx = 100
  xmax = 1
[]


[Variables]
  # [./u]
  #   order = FIRST
  #   family = LAGRANGE
  # [../]
  [./u]
    order = FIRST
    family = MONOMIAL
  [../]
[]

[Kernels]
  [./time]
    type = TimeDerivative
    variable = u
  [../]
  [./test_u]
    type = Diffusion
    variable = u
  [../]
  [./adv_u]
    type = GAdvection
    variable = u
    vx = 10000
    vy = 0
    vz = 0
  [../]
[]

[DGKernels]
  [./dg_advection]
    type = DGAdvection
    variable = u
    vx = 10000
    vy = 0
    vz = 0
  [../]
  [./dg_diffusion]
    type = DGDiffusion
    variable = u
    sigma = 0
    epsilon = -1
  [../]
[]

[BCs]
  [./left]
    type = InflowBC
    variable = u
    boundary = 'left'
    inlet_conc = 2
    vx = 10000
  [../]
 #  [./left]
 #   type = PenaltyDirichletBC
 #   penalty = 1e6
 #   value = 1
 #   boundary = left
 #   variable = u
 # [../]
 #  [./right]
 #   type = RobinBC
 #   boundary = right
 #   variable = u
 #   vx = 1000
 # [../]
 #  [./right]
 #   type = PenaltyDirichletBC
 #   penalty = 10000
 #   value = 0
 #   boundary = right
 #   variable = u
 # [../]
  [./right]
    type = OutflowBC
    variable = u
    boundary = 'right'
    vx = 10000
  [../]
[]

[ICs]
  # [./u_ic]
  #   type = RandomIC
  #   variable = u
  # [../]
  # [./u_ic]
  #   type = FunctionIC
  #   variable = u
  #   function = init_func
  # [../]
  [./u_ic]
    type = ConstantIC
    variable = u
    value = 0
  [../]
[]

[Functions]
  [./init_func]
    type = ParsedFunction
    value = '1*(1-x)'
  [../]
[]

[Materials]
  [./jac]
    block = '0'
    type = JacMat
  [../]
[]

[Preconditioning]
  [./fdp]
    type = SMP
    full = true
  [../]
[]

[Executioner]
  type = Transient
  dt = 0.000001
  end_time = .0001
  dtmin = 0.0000001
  nl_abs_tol = 1e-12
  scheme = crank-nicolson
  # type = Steady
  solve_type = NEWTON
  petsc_options = '-snes_converged_reason  -pc_svd_monitor -snes_linesearch_monitor -options_left -snes_test_display'
  petsc_options_iname = '-pc_type -ksp_type'
  petsc_options_value = 'lu preonly'
  # petsc_options_iname = '-snes_type'
  # petsc_options_value = 'test'
[]

[Outputs]
  exodus = true
  print_linear_residuals = false
[]

[Debug]
  show_var_residual_norms = true
[]