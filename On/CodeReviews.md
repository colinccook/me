# Colin Cook on... Code Reviews
1. [Scope](#scope)
2. [Background](#background)

## Scope

These guidelines have been written to encourage a standard of user story writing. Following the guidelines below allow user stories to be independently verified (with the stakeholders where necessary).

User story writing is an art form that is time consuming to do well. This document will be updated as QA encounter user stories that are difficult to understand.

✔ Do endeavour to capture the spirit of the change  
❌ Don't chase perfection; a good QA team will work with you to address any uncertainty when necessary  

## Background

In my decade-long career as a Software Engineer, I have been involved with hundreds of incoming requirements from the business.

The last six and a half years has been part of a Scrum team. After many retrospectives and learning the nuiances of Scrum-led project management, I have written the below guidelines of user story writing of what I consider to result in better outcomes.

## The importance of quality User Stories

Everyone involved in software development should be vigilant in growing user stories. Well scoped stories result in:

- A shared development team understanding of the original requirement through conversation
- Stakeholder reassurance that their needs are being met
- Developers feeling empowered and coming up with creative solutions for a well defined problem
- Helps advanced development practices such as DDD and TDD
- Allows interested parties, within and outside of the development, to understand the change and to be more collaborative

## Work with your Product Owners

If you're lucky enough to work with your Product Owners... Traditionally, Product Owners will create TODO

They will be vague, uncomplete, and at the bottom of your Product Backlog.

✔ Only Product Owners can change the Title and Acceptance Criteria whilst in sprint

## User Story Title

The title of a story is key as it is the main driver for the intent of the functionality needed. 

For instance:
> Assign an emergency contact to a Tenancy Member

<details>
  <summary><b>✔ Story titles should indicate intent, and not specify the implementation</b></summary></br>

Instead of: ❌ "Letter Manager LPG Engineers"
✔ "Book an LPG service with a qualified enginner"

</details>

<details>
  <summary><b>✔ Write story titles which you could prefix "The ability to" at the beginning</b></summary></br>

Instead of: 
❌ "Allow users to book a customer's next service"
✔ [The ability to] "Book the next service for a customer"

</details>

## User Story content

An excellent starting point for User Stories is the `As A... I want to... So that...` syntax.

It teases out the what, who and why of a requirement.

For instance:
> As a Security Team administrator  
> I want to keep an up-to-date list of Staff Safety Alerts on a Property  
> So that visiting Staff can take the necessary precautions when visiting a Property 

<details>
  <summary><b>✔ As a... Must relate to a job role</b></summary></br>
✔ Do put `As a Security Team administrator`, and ask, what does a Security Team administrator do day-to-day?  
❌ Do not put `As a User...`, it is too vague and will not inspire a further discussion  
❌ Do not put `As an Authentication Service...`, it suggests we are talking about a requirement that isn't a stakeholder user story</br>

</details>

<details>
  <summary><b>✔ As a... Must be understood by the Development Team</b></summary></br>
✔ Context is key. If a developer can articulate why the role defined would benefit from the change, then there is a higher chance of 
</details>

<details>
  <summary><b>❌ So that... Should not be vague</b></summary></br>
TODO
</details>

<details>
  <summary><b>❌ So that... Should not be swappable with the "I want" part</b></summary></br>
TODO
</details>

## User Story Acceptance Criteria

The User Story Acceptance Criteria 

✔ If you use project management tools like JIRA, create a explicit and mandatory column called `Acceptance Criteria`

### 4. Acceptance Criteria should be broken down

Every relevant scenario should be covered. It should be treated as a checklist when peer reviewed and quality assured.

✔ Separate your ACs into a list ❌ Do not write a long paragraph mixing the ACs together

### 5. Use business language rather than implementation details

User stories are the conduit between IT and the stakeholders; encapsulating their needs with their language will assure them that they're getting the right changes.

✔ The business should be able to read through the acceptance criteria of a story and make sense of it

Ensure the role of the person is defined, to give context of who they are and what they're trying to do.

Instead of: 
❌ As a user
❌ As an overnight batching process
✔ As a Housing Officer

Rather than referencing the user interface or specifics, reference the business process instead; the *intent* and not the *how*.

Instead of: 
❌ I want a button that emails a tenant's statement to them
✔ I want to inform the tenant of their account status

Instead of: 
❌ So they get an email
✔ So that they can make an informed decision on how to pay us

The `So that...` should cover the act that wasn't achievable before (therefore making this task a story)

❌ So that it makes our Housing Officers happy
✔ So that they can make an informed decision on how to pay us

Beware of `So they cannot...`; this suggests a bug rather than a user story

❌ So that they cannot put invalid data when entering their sign up details

## Is it actually a User Story?

Categorising backlog items to the 

## Don't let scope creep happen

Pull a story out if it grows


## Peer Reviewing Recommendations

Any acceptance criteria that fails a "happy-path" will be seen as a *showstopper* for a release. Therefore it's important that the development team is confident that every AC has been met.

✔ Include consise happy-path instructions in the ticket that prove the AC has been met

For a user story pull request, every line of code that's changed should match to an AC

✔ Have a conversation with the team if you feel a line was changed that doesn't fit into an AC

## How the QA team perform acceptance testing

It's QA's role to inspect a story, come up with a test plan, execute it and feedback whether it is fit for purpose. The plan will contain acceptance tests. 

Good quality acceptance criteria will allow the team to come up with inventive tests. "Edge cases" can then be identified, and fails are confirmed with stakeholders whether they are showstoppers or not.

Acceptance tests follow the `Given... When... Then...` syntax. They are much closer to the implementation and will reference specifics.

An example being:
> Given I have a site where the LPG fuel type has an overdue service  
> When I generate a letter 1  
> Then only engineers with 'LPG Qual - Changeover NG to LPG' are assigned to the job  

Depending on the scope of the AC, dozens of acceptance tests could be identified.