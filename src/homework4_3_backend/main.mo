import List "mo:base/List";
import Iter "mo:base/Iter";
import Principal "mo:base/Principal";
import Text "mo:base/Text";
import Time "mo:base/Time";

actor {
  public type Message = {
    message: Text;
    time: Int;
  };  

  public type Microblog = actor {
    follow: shared(Principal) -> async ();
    follows: shared query () -> async [Principal];
    post: shared (Text) -> async ();
    posts: shared query () -> async [Message];
    timeline: shared () -> async [Time];
  };

  stable var followed : List.List<Principal> = List.nil();

  public shared func follow(id: Principal) : async () {
    followed := List.push(id, followed);
  };

  public shared func follows() : async [Principal] {
    List.toArray(followed);
  };

  stable var messages : List.List<Message> = List.nil();

  public shared (msg) func post(text: Text) : async () {
    assert(Principal.toText(msg.caller) == "i2uwu-eljks-axg63-cbrl2-rqor7-lyxeh-uuy52-bdvfs-qjscz-a2ntj-aae");
    messages := List.push(text, messages);
  };

  public shared query func posts(since: Time.Time) : async [Message] {
    List.toArray(messages)
  };

  public shared func timeline(since Time.Time) : async [Message] {
    var all : List.List<Message> = List.nil();
    let now : List.List<Time> -> Time

    switch (Message.time){
      case (#time) (Message.time >= );
      case (#time) (Message.time );
    }

    for (id in Iter.fromList(followed)) {
      let canister : Microblog = actor(Principal.toText(id));
      let msgs = await canister.posts();
      for (msg in Iter.fromArray(msgs)) {
        all := List.push(msg, all)
      }
    };

    List.toArray(all)
  };
};
