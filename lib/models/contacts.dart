import 'dart:collection';

class Contact{

 String name,email,messagesURL;

  Contact (this.name, this.email,this.messagesURL);
}

class ContactList{
 List <Contact> _Contacts= [];

 List<Contact> get Contacts => UnmodifiableListView(_Contacts);

void addContact(Contact contact){
 bool isAdded=false;
 for(int i=0 ;i<_Contacts.length;i++){
  if(contact.email==_Contacts[i].email){
   isAdded=true;
   break;
  }
 }
 if(!isAdded)
 _Contacts.add(contact);
}


}