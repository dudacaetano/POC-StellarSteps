import SwiftUI
import SwiftData

class TaskViewModel: ObservableObject {
    
    func loadTasks(for context: ModelContext) {
        let staticTasks: [TaskDTO] = [
            TaskDTO(
                name: "Put toys away",
                duration: 300,
                category: .routineAndOrganization,
                info: "Encourage your child to place toys back in bins or shelves after playing to keep their space tidy.",
                childTips: "Let’s put all your toys in their special places! Cars go here, and dolls go there. You’re so great at tidying up!"
            ),
            TaskDTO(
                name: "Fold laundry",
                duration: 180,
                category: .routineAndOrganization,
                info: "Help fold smaller items like washcloths, socks, or their own clothes with simple instructions.",
                childTips: "Time to fold! Start with the socks—match them up like buddies, and then we’ll tackle the shirts. You’re a folding pro!"
            ),
            TaskDTO(
                name: "Dust with sock",
                duration: 300,
                category: .routineAndOrganization,
                info: "Give your child an old sock to wear on their hand and let them wipe down low surfaces like shelves or furniture.",
                childTips: "Slip that sock on and let’s go on a dust hunt! Swipe the dust away, and we’ll make everything look shiny."
            ),
            TaskDTO(
                name: "Organize play area",
                duration: 300,
                category: .routineAndOrganization,
                info: "Guide your child to sort toys by type (e.g., cars, blocks) and place them in specific bins or baskets.",
                childTips: "Let’s sort your toys! Cars with cars, and blocks with blocks. When we’re done, your play area will be all set for fun!"
            ),
            TaskDTO(
                name: "Dust window sills",
                duration: 180,
                category: .routineAndOrganization,
                info: "Have your child use a soft cloth to wipe down the window sills, removing dust and dirt.",
                childTips: "Ready to dust the window? Wipe the sill from one side to the other, and soon it’ll be all clean and neat!"
            ),
            TaskDTO(
                name: "Empty bathroom can",
                duration: 120,
                category: .routineAndOrganization,
                info: "Let your child carry a small bathroom trash can to the main trash bin and empty its contents.",
                childTips: "Let’s grab the bathroom trash! Carefully carry it to the big bin, and yay—trash is gone!"
            ),
            TaskDTO(
                name: "Fill dog bowl",
                duration: 120,
                category: .healthAndDevelopment,
                info: "Supervise your child as they pour dog food into the bowl, using a scoop or small cup to avoid spills.",
                childTips: "Let’s feed the pet! Scoop the food carefully and pour it into the bowl. Your furry friend will be so happy!"
            ),
            TaskDTO(
                name: "Packing lunch bag",
                duration: 120,
                category: .healthAndDevelopment,
                info: "Involve your child by letting them place pre-packed items like snacks or drinks into their lunch bag.",
                childTips: "Time to pack your lunch! Put in your sandwich, snack, and juice. You’re the best at making sure everything fits just right!"
            ),
            TaskDTO(
                name: "Help make grocery list",
                duration: 300,
                category: .healthAndDevelopment,
                info: "Ask your child to help by reminding you of items they need or want, or by drawing simple pictures.",
                childTips: "Let’s make a shopping list! What foods do we need? Draw a nice, colorful picture of all the things you're out of!"
            ),
            TaskDTO(
                name: "Put clothes in hamper",
                duration: 120,
                category: .personalHygiene,
                info: "Encourage your child to put their dirty clothes in the hamper after changing or bathing.",
                childTips: "Dirty clothes go in the hamper! When you change, just toss them in, and you’re all set for the next day!"
            ),
            TaskDTO(
                name: "Help water plants",
                duration: 300,
                category: .healthAndDevelopment,
                info: "Give your child a small watering can or cup and let them water indoor plants with guidance on how much to use.",
                childTips: "Time to water the plants! Give each one a little drink, but not too much. You’ll help them grow big and strong!"
            ),
            TaskDTO(
                name: "Set the table",
                duration: 300,
                category: .routineAndOrganization,
                info: "Your child can help by placing napkins, utensils, or non-breakable dishes on the table before meals.",
                childTips: "Let’s set the table! Napkins here, forks there, and the table will be ready for a yummy meal."
            ),
            TaskDTO(
                name: "Make the bed",
                duration: 180,
                category: .personalHygiene,
                info: "Show your child how to straighten the blankets and arrange pillows, making the bed look neat and tidy.",
                childTips: "Let’s make your bed! Pull up the blanket and fluff the pillow. Ask your teddy to help too!"
            )
        ]
        
        for task in staticTasks {
            context.insert(task)
        }
        
        do {
            try context.save()
        }catch {
            print("Erro ao carregar Atividades")
        }
    }
}

