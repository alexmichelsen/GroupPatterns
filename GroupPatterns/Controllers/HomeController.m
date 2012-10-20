#import "HomeController.h"


@implementation HomeController {

}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationItem.title = @"Home";
}

- (void)viewWillAppear:(BOOL)animated {
  self.navigationController.navigationBar.hidden = true;
}

- (void)viewWillDisappear:(BOOL)animated {
  self.navigationController.navigationBar.hidden = false;
}

- (IBAction)buyADeck {
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:BUY_URL]];
}

- (IBAction)dealACard {

}


@end