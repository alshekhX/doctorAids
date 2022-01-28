class Order {
  String? id;
  String? quantity;

  Order(this.id, this.quantity);


 Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "quantity": quantity == null ? null : quantity,
      
    };}
