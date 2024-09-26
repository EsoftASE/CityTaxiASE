 <!-- Header-->
 <header class="bg-dark py-5" id="main-header">
    <div class="container h-100 d-flex align-items-center justify-content-center w-100">
        <div class="text-center text-white w-100">
            <h1 class="display-4 fw-bolder mx-5"><?php echo $_settings->info('name') ?></h1>
            <div class="col-auto mt-4">
                <!-- <a class="btn btn-warning btn-lg rounded-0" href="./?p=booking">Book Now</a> -->
            </div>
        </div>
    </div>
</header>
<!-- Section-->
<section class="py-5">
    <div class="container">
        <div class="card shadow card-outline card-warning rounded-0">
            <div class="card-body">
                <?php include './welcome.html' ?>
                
            </div>
        </div>

<!--about us and car image/taxi image-->
        <div class="card-body d-flex flex-column flex-md-row align-items-center">
    <div class="text-content mb-3 mb-md-0 mr-md-3">
        <?php include "about.html" ?>
    </div>
    <img src="dist/img/about-img.png" alt="About Image" class="img-fluid ml-md-auto" style="width: 450px; height: 250px;">
</div>

<div class="container my-5">
    <div class="row align-items-center">
        <!-- Title Section (Text and Divider) -->
        <div class="col-md-4">
            <h2 class="font-weight-bold">Our <br> Taxi Services</h2>
            <div class="bg-warning" style="width: 50px; height: 3px; margin-bottum: 200px;"></div>
        </div>

        <!-- Service Items Section -->
        <div class="col-md-8">
            <div class="row text-center">
                <!-- Service 1 -->
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="service-box">
                        <img src="dist/img/delivery-man.png" class="img-fluid mb-3" alt="Private Driver" style="max-width: 80px;">
                        <h5 class="font-weight-bold">Private Driver</h5>
                        <p class="text-muted">Lorem ipsum dolor sit ame</p>
                        <a href="#" class="btn btn-outline-dark">Read More</a>
                    </div>
                </div>

                <!-- Service 2 -->
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="service-box">
                        <img src="dist/img/airplane.png" class="img-fluid mb-3" alt="Airport Transfer" style="max-width: 120px;">
                        <h5 class="font-weight-bold">Airport Transfer</h5>
                        <p class="text-muted">Lorem ipsum dolor sit ame</p>
                        <a href="#" class="btn btn-outline-dark">Read More</a>
                    </div>
                </div>

                <!-- Service 3 -->
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="service-box">
                        <img src="dist/img/backpack.png" class="img-fluid mb-3" alt="Luggage Transfer" style="max-width: 80px;">
                        <h5 class="font-weight-bold">Luggage Transfer</h5>
                        <p class="text-muted">Lorem ipsum dolor sit ame</p>
                        <a href="#" class="btn btn-outline-dark">Read More</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


    </div>
</section>
<script>
    $(function(){
        $('#search').on('input',function(){
            var _search = $(this).val().toLowerCase().trim()
            $('#service_list .item').each(function(){
                var _text = $(this).text().toLowerCase().trim()
                    _text = _text.replace(/\s+/g,' ')
                    console.log(_text)
                if((_text).includes(_search) == true){
                    $(this).toggle(true)
                }else{
                    $(this).toggle(false)
                }
            })
            if( $('#service_list .item:visible').length > 0){
                $('#noResult').hide('slow')
            }else{
                $('#noResult').show('slow')
            }
        })
        $('#service_list .item').hover(function(){
            $(this).find('.callout').addClass('shadow')
        })
        $('#service_list .view_service').click(function(){
            uni_modal("Service Details","view_service.php?id="+$(this).attr('data-id'),'mid-large')
        })
        $('#send_request').click(function(){
            uni_modal("Fill the Service Request Form","send_request.php",'large')
        })

    })
    $(document).scroll(function() { 
        $('#topNavBar').removeClass('bg-transparent navbar-light navbar-dark bg-gradient-warning text-light')
        if($(window).scrollTop() === 0) {
           $('#topNavBar').addClass('navbar-dark bg-transparent text-light')
        }else{
           $('#topNavBar').addClass('navbar-light bg-gradient-warning ')
        }
    });
    $(function(){
        $(document).trigger('scroll')
    })
</script>