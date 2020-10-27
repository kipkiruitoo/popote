import '../models/service.dart';

List<Service> getServices(){
  List<Service> services = new List<Service>();


  //Birth
  Service birth = new Service(
      name: "Birth",
      image: "birth.png"
  );
  services.add(birth);

  //Health
  Service health = new Service(
      name: "Health",
      image: "health.png"
  );
  services.add(health);

  //Education
  Service education = new Service(
      name: "Education",
      image: "education.png"
  );
  services.add(education);

  //Turning 18
  Service turning18 = new Service(
      name: "Turning 18",
      image: "turning-18.png"
  );
  services.add(turning18);

  //Lost Documents
  Service lostDocuments = new Service(
      name: "Lost Documents",
      image: "lost-documents.png"
  );
  services.add(lostDocuments);

  //Complaints
  Service complaints = new Service(
      name: "Complaints",
      image: "complaints.png"
  );
  services.add(complaints);


  //Work
  Service work = new Service(
      name: "Work",
      image: "work.png"
  );
  services.add(work);


  //licences
  Service licences = new Service(
      name: "Licences and Permit",
      image: "licenses-and-permit.png"
  );
  services.add(licences);

  //business
  Service business = new Service(
      name: "Business",
      image: "business.png"
  );
  services.add(business);


  //business
  Service taxes = new Service(
      name: "Paying Taxes",
      image: "paying-taxes.png"
  );
  services.add(taxes);

  //business
  Service driving = new Service(
      name: "Driving",
      image: "driving.png"
  );
  services.add(driving);

  //business
  Service marriage = new Service(
      name: "Marriage",
      image: "marriage.png"
  );
  services.add(marriage);


  //business
  Service landHousing = new Service(
      name: "Land and Housing",
      image: "land-and-housing.png"
  );
  services.add(landHousing);

  //business
  Service travel = new Service(
      name: "Travel",
      image: "travel.png"
  );
  services.add(travel);

  //business
  Service disability = new Service(
      name: "Disability",
      image: "disability.png"
  );
  services.add(disability);


  //business
  Service retirement = new Service(
      name: "Retirement",
      image: "retirement.png"
  );
  services.add(retirement);

  //business
  Service death = new Service(
      name: "Death",
      image: "death.png"
  );
  services.add(death);



  return services;



}