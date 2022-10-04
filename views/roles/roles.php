<?=
   component('header' , $data);
   getModal('mdlRoles', $data);
?>

<!-- Main -->
   <div id="contentAjax"></div>
   <main class="app-content">
      <div class="app-title">
         <div>
            <h1>
               <i class="breadcrumb-item__icon <?= $data['page_icon']; ?> fa-lg"></i>
               <span><?= $data['page_title']; ?></span>
            </h1>
            <p><?= $data['page_description']; ?></p>
         </div>
         <ul class="app-breadcrumb breadcrumb">
            <li class="breadcrumb-item">
               <a href="<?= path; ?>">Inicio</a>
            </li>
            <li class="breadcrumb-item">
               <i class="breadcrumb-item__icon <?= $data['page_icon']; ?> fa-xl"></i>
               <a><?= $data['page_breadcrumb']; ?></a>
            </li>
         </ul>
      </div>
      <div class="row">
         <div class="col-md-12">
            <div class="tile">
               <div class="tile-body">
                  <table id="tblRoles" class="table table-bordered table-hover table-striped table-sm display nowrap" cellpading="0" style="width:100%">
                     <thead class="bg bg-black text-light text-center">
                        <tr>
                           <th width="5%">No.</th>
                           <th width="30%">Nombre del Rol</th>
                           <th width="30%">Descripción del Rol</th>
                           <th width="10%">Creado por</th>
                           <th width="5%">Estado</th>
                           <th width="10%">Acciones</th>
                        </tr>
                     </thead>
                  </table>
               </div>
            </div>
         </div>
      </div>
   </main>

<?= component('footer', $data) ?>