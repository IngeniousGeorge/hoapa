# Notes

## On runtime code

Exactly what the code does

  Hoapa.Core.EventLog is one process holding seven pieces of state: four fixed strings set at startup (run_id, protocol_id, sibling_protocol_ids, trace_format) and three lists that start
  empty — actors, conversations, events.

  It accepts four operations. Three of them append: record_actor adds a string, record_conversation adds a conversation record, append_event adds an event record. Each prepends to the
  front of its list, which is why export reverses once. The fourth, export_run, packages the three reversed lists into a %Hoapa.Contract.Run{} and hands it back without changing the state.

  That is the entire behaviour. There is no branching, no lookup, no comparison of one record against another. The reason it's a process at all rather than a data structure is that a
  process has a mailbox: it handles one message at a time, so "the order things were recorded in" is a well-defined thing rather than a race. The module is ~40 lines of behaviour under ~80
  lines of documentation, and the test file is four times its size. That ratio is the point, not an accident.

  The plain-terms mapping, with the traps

  A participant is an actor ID — an opaque string. The code can tell that two IDs are the same string or different strings, and nothing else. It cannot tell you whether a participant is a
  person, cannot ask for attributes, cannot sort or rank them, cannot group them into kinds. That is not an omission waiting to be filled in; it is the "unityped probes" half of the
  project's second conjecture, enforced by leaving the capability out. The trusted record deliberately excludes names, addresses, keys, and person identity so that no downstream proof can
  ever come to depend on who someone is.

  The limit worth stating precisely: what's grounded is that discipline — opaque participants, no identity-refining fields. What is not yet proved is the stronger claim that no observation
  the system permits could define a ranking over participants. That's the no-leak ladder, and it's still pending 2S work.

  A sentence is where the intuition breaks hardest. There are no sentences here. An event records that a turn occurred — in which conversation, which participants it touched, what it
  declares itself to depend on, plus a content_tag and a provenance_token that are opaque strings. The words are not in the record and are not meant to be. So an event is closer to
  "something happened here, and here is its shape and its dependencies" than to "here is what was said." If you want the one-line version: the system records the structure of an exchange
  and refuses to record its content.

  A conversation is nearer to the everyday word, but formally it is a local view: which participants are present, and an opaque tag for the shape of the exchange. It is the unit of
  locality — roughly, what is visible from inside it. Crucially a run holds many, and an event in one conversation may depend on an event in another. That cross-conversation dependency is
  the case the whole design bends around.

  The session tag points at the other half of the conjecture — typed documentation, the shape an exchange is supposed to take. At v0 it is an opaque string and the runtime is explicitly
  forbidden from inventing a vocabulary for it. It's a reserved slot, honestly labelled as one.

  Memory is the mapping I'd most want to adjust. This is not memory in the sense of "the system remembers what you told it." It is a ledger of evidence: a record of what happened, in a
  form an outside authority can check. Minutes of a meeting, or a flight recorder, rather than a memory. It stores structure so that someone else can later ask "was this exchange
  well-formed?" — and it stores no content that would let anyone reconstruct what was said.

  The two orders — the real idea in this session

  The log knows the order in which records reached it. That is bookkeeping, and partly an accident of timing.

  Separately, each event carries an explicit list of what it depends on — supplied by the caller, never inferred.

  The entire discipline of this session is refusing to let the first pretend to be the second. Minutes of a meeting record the order in which people spoke; they do not thereby establish
  who was replying to whom. If B was recorded after A, the log will not conclude B was a response to A. Someone must say so. The wording in the module is deliberate: export preserves the 
  order in which the server handles recording calls; this is evidence order, not actor-execution order or causal order.

  Recorder, not judge

  The log never decides whether anything is legitimate. It will faithfully record two turns with the same ID, a reply to something that never happened, a reply to something that happens
  later, and an unrecognized format tag. Judging is a separate authority — the machine-checked mathematics in Agda — and the runtime's only job is to hand it an unretouched record.

  The reason this matters more than it sounds: if the recorder tidied as it went, the judge would be judging the tidied version, and you could no longer tell whether the system behaved
  well or the recorder covered for it. That is why so much of today went into proving the recorder doesn't tidy — deliberately breaking it five ways and confirming a test caught each one.

  Two of those results were interesting. If the log had derived the participant list from who joined conversations, the small canonical example wouldn't have noticed — only the case with
  someone present who joins nothing catches it. And if it had quietly dropped references to things that don't exist, only the dangling-reference case catches that. Both guards are
  load-bearing precisely where the obvious example is blind.

  One decision actually made today

  "Can someone be registered as present but take part in no conversation at all?" The answer is now yes — registration is independent of participation, and such a run is legal evidence,
  not an error to warn about. Whether every registered participant is covered by some conversation became a separate named property on the mathematical side (actorsCovered?), assumed where
  it's needed rather than enforced everywhere.

  Where this sits in the project

  The three lanes: 1C pure conjecture, 2S the interpretation joining runtime evidence to the mathematics, 3R the running system. The rule is that 3R echoes 2S — the runtime must not invent
  meaning ahead of the formal side. Today was 3R, and the brief you relayed was largely 2S telling me which choices were already fixed so the runtime wouldn't quietly decide them first.

  The two legs meet at exactly one place: the contract, a small JSON shape with a fixture corpus that acts as executable specification. Claims about what's acceptable live there with an
  expected verdict, never in runtime tests.

  And the piece the runtime is echoing is ConversationLocality.agda: each conversation is realized as its own small world, with a faithful structure-preserving embedding into the global
  picture. The runtime emits against those local views rather than inventing its own notion of locality. The next run to build — one that starts in a conversation, passes through a second,
  and returns — is exactly the case that machinery was designed for and has never been tested on. That's pass 2.

  What this is not, yet

  There is no message content, no delivery, no people, no storage that survives a restart, no interface. What exists is an evidence format and one process that produces it faithfully.
  Everything above describes the shape of the thing, not a working chat system — and the shape was the hard part, which is rather the Grothendieckian bet the project is making.