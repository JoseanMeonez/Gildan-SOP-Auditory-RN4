<!-- Sidebar -->
<div class="app-sidebar__overlay" data-bs-toggle="sidebar"></div>
   <aside class="app-sidebar">
      <div class="app-sidebar__user">
         <img class="app-sidebar__user-avatar" src="<?= media; ?>/images/avatars/avatar10.svg" alt="User Avatar">
         <div>
            <p class="app-sidebar__user-name"><?= $_SESSION['userdata']['NAME']; ?></p>
            <p class="app-sidebar__user-role"><?= $_SESSION['userdata']['rol_name']; ?></p>
         </div>
      </div>
      <ul class="app-menu">
      <!-- Dashboard -->
         <!-- <?php // if(!empty($_SESSION['permissions'][1]['per_r'])) : ?> -->
            <li>
               <a class="app-menu__item active" href="<?= path; ?>">
                  <i class="app-menu__icon fa-solid fa-house-chimney"></i>
                  <span class="app-menu__label">Inicio</span>
               </a>
            </li>
         <!-- <?php // endif; ?> -->
				 
				 
				 <!-- Knitting -->
				 <li class="treeview">
						<a class="app-menu__item" href="#" data-bs-toggle="treeview">
							<i class="app-menu__icon fa-solid fa-socks"></i>
							<span class="app-menu__label">Knitting</span>
							<i class="treeview-indicator fa-solid fa-angle-right"></i>
						</a>
						<ul class="treeview-menu">
							<li>
									<a class="treeview-item" href="<?= path; ?>/home/knitting">
										<i class="icon fa-solid fa-solid fa-circle-dot"></i>
										<span class="treeview-item__label"> Auditorias</span>
									</a>
							</li>
						</ul>
				</li>

				<!-- Dyeing -->
				<li class="treeview">
					<a class="app-menu__item" href="#" data-bs-toggle="treeview">
						<i class="app-menu__icon fa-solid fa-vial-circle-check"></i>
						<span class="app-menu__label">Dyeing</span>
						<i class="treeview-indicator fa-solid fa-angle-right"></i>
					</a>
					<ul class="treeview-menu">
						<li>
								<a class="treeview-item" href="<?= path; ?>/home/dyeing">
									<i class="icon fa-solid fa-solid fa-circle-dot"></i>
									<span class="treeview-item__label"> Auditorias</span>
								</a>
						</li>
					</ul>
				</li>
				 

				<!-- Boarding -->
				<li class="treeview">
					<a class="app-menu__item" href="#" data-bs-toggle="treeview">
						<i class="app-menu__icon fa-solid fa-boxes-packing"></i>
						<span class="app-menu__label">Boarding</span>
						<i class="treeview-indicator fa-solid fa-angle-right"></i>
					</a>
					<ul class="treeview-menu">
						<li>
								<a class="treeview-item" href="<?= path; ?>/home/boarding">
									<i class="icon fa-solid fa-solid fa-circle-dot"></i>
									<span class="treeview-item__label"> Auditorias</span>
								</a>
						</li>
					</ul>
				</li>
      <!-- Users -->
         <!-- <?php // if (!empty($_SESSION['permissions'][3]['per_r'])) : ?> -->
            <li class="treeview">
               <a class="app-menu__item" href="#" data-bs-toggle="treeview">
                  <i class="app-menu__icon fa-solid fa-user-lock"></i>
                  <span class="app-menu__label">Usuarios</span>
                  <i class="treeview-indicator fa-solid fa-angle-right"></i>
               </a>
               <ul class="treeview-menu">
                  <li>
                     <a class="treeview-item" href="<?= path; ?>/home/users">
                        <i class="icon fa-solid fa-solid fa-circle-dot"></i>
                        <span class="treeview-item__label"> Listado de Usuarios</span>
                     </a>
                  </li>
               </ul>
            </li>
         <!-- <?php // endif; ?> -->
      <!-- Logout -->
         <li>
            <a class="app-menu__item" href="<?= path; ?>/logout">
               <i class="app-menu__icon fa-solid fa-power-off fa-lg"></i>
               <span class="app-menu__label">Cerrar Sesión</span>
            </a>
         </li>
      </ul>
   </aside>