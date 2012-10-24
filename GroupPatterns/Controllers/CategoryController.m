#import "CategoryController.h"
#import "CardListController.h"
#import "Category.h"
#import "Card.h"

@interface CategoryController ()
@property(nonatomic, strong) Category *category;

@end

@implementation CategoryController {

@private
  CardListController *_cardListController;
  Category *_category;
  NSString *_categoryName;
}

@synthesize cardListController = _cardListController;
@synthesize category = _category;
@synthesize categoryName = _categoryName;


- (void)viewDidLoad {
  [super viewDidLoad];
  self.category = [[self.cardListController.categories find:^(Category *c) {
    return [c.name isEqualToString:_categoryName];
  }] get];

  self.navigationItem.title = self.category.name;
  [self loadHTMLString:[self categoryHtml]];
}

- (NSString *)categoryHtml {
  NSLog(@"[self.category.cards description] = %@", [self.category.cards description]);
  NSString *html = [NSString stringWithFormat:@"<html>"
                                                  "<head>"
                                                  "<style type='text/css'>"
                                                  "body { font-family: 'Avenir-Book'; padding: 0 10px; }"
                                                  ".image-container { "
                                                  "  text-align: center; "
                                                  "  padding-bottom: 10px;"
                                                  "}"
                                                  "img { width: 50px; }"
                                                  ".description, .related { margin: 10px 0; }"
                                                  ".description, .related { font-size: 1.1em }"
                                                  ".related h3 { font-size: 1em; margin: 10px 0 0 }"
                                                  ".related a { display: block; }"
                                                  "</style>"
                                                  "</head>"
                                                  "<body>"
                                                  "<div class='image-container'><img src='%@'></img></div>"
                                                  "<div class='description'>%@</div>"
                                                  "<div class='related'><h3>Patterns</h3>%@</div>"
                                                  "</body></html>",
          [self.category imageName],
          [self.category desc],
          [self cardLinksHtml:self.category.cards]
  ];
  return html;
}

- (NSString *)cardLinksHtml:(NSArray *)someCards {
  return [[someCards map:^(Card *card) {
    return [NSString stringWithFormat:@"<a href='/cards/%@'>%@</a>", card.name, card.name];
  }] componentsJoinedByString:@""];
}

- (BOOL)webView:(UIWebView *)aWebView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
  NSString *name = [[request URL] lastPathComponent];
  NSString *type = [[[request URL] pathComponents] objectAtIndex:1];

  if ([type isEqualToString:@"cards"]) {
    [self.navigationController popToViewController:self.cardListController animated:false];
    [self.cardListController openCardWithName:name];
    return FALSE;

  } else {
    return TRUE;
  }
}

@end