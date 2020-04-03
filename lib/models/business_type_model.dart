enum OrderBy { TO_ME, TO_MY_BUSINESS }

class BusinessTypeModel {
  BusinessTypeModel({
    this.orderBy = OrderBy.TO_ME,
  });

  OrderBy orderBy;
}
