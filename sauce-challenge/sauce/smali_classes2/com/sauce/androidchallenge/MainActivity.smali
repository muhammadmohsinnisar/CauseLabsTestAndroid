.class public Lcom/sauce/androidchallenge/MainActivity;
.super Landroidx/appcompat/app/AppCompatActivity;
.source "MainActivity.java"


# instance fields
.field private ingredient1:Landroid/widget/EditText;

.field private ingredient2:Landroid/widget/EditText;

.field private ingredient3:Landroid/widget/EditText;

.field private messageText:Landroid/widget/TextView;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 13
    invoke-direct {p0}, Landroidx/appcompat/app/AppCompatActivity;-><init>()V

    return-void
.end method

.method private getMessage(Ljava/lang/String;Z)Ljava/lang/String;
    .locals 2
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "isCorrect"    # Z

    .line 47
    const/4 v0, 0x0

    const/4 v1, 0x1

    if-eqz p2, :cond_0

    new-array v1, v1, [Ljava/lang/Object;

    aput-object p1, v1, v0

    .line 48
    const-string v0, "The %s ingredient is <font color=\'#4a8d28\'><b>correct</b></font>.<br />"

    invoke-static {v0, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_0
    new-array v1, v1, [Ljava/lang/Object;

    aput-object p1, v1, v0

    .line 49
    const-string v0, "The %s ingredient is <font color=\'#c35151\'><b>incorrect</b></font>.<br />"

    invoke-static {v0, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 47
    :goto_0
    return-object v0
.end method

.method private showMessage(Landroid/text/Spanned;)V
    .locals 1
    .param p1, "spanned"    # Landroid/text/Spanned;

    .line 68
    iget-object v0, p0, Lcom/sauce/androidchallenge/MainActivity;->messageText:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 69
    return-void
.end method

.method private validateFirstIngredient(Ljava/lang/String;)Z
    .locals 2
    .param p1, "input"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 53
    invoke-static {p0}, Lcom/sauce/first/IngredientFinder;->find(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 54
    .local v0, "ingredient":Ljava/lang/String;
    invoke-static {v0, p1}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    return v1
.end method

.method private validateIngredients()V
    .locals 4

    .line 36
    :try_start_0
    const-string v0, ""

    .line 37
    .local v0, "message":Ljava/lang/String;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "first"

    iget-object v3, p0, Lcom/sauce/androidchallenge/MainActivity;->ingredient1:Landroid/widget/EditText;

    invoke-virtual {v3}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {p0, v3}, Lcom/sauce/androidchallenge/MainActivity;->validateFirstIngredient(Ljava/lang/String;)Z

    move-result v3

    invoke-direct {p0, v2, v3}, Lcom/sauce/androidchallenge/MainActivity;->getMessage(Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    move-object v0, v1

    .line 38
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "second"

    iget-object v3, p0, Lcom/sauce/androidchallenge/MainActivity;->ingredient2:Landroid/widget/EditText;

    invoke-virtual {v3}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {p0, v3}, Lcom/sauce/androidchallenge/MainActivity;->validateSecondIngredient(Ljava/lang/String;)Z

    move-result v3

    invoke-direct {p0, v2, v3}, Lcom/sauce/androidchallenge/MainActivity;->getMessage(Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    move-object v0, v1

    .line 39
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "third"

    iget-object v3, p0, Lcom/sauce/androidchallenge/MainActivity;->ingredient3:Landroid/widget/EditText;

    invoke-virtual {v3}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {p0, v3}, Lcom/sauce/androidchallenge/MainActivity;->validateThirdIngredient(Ljava/lang/String;)Z

    move-result v3

    invoke-direct {p0, v2, v3}, Lcom/sauce/androidchallenge/MainActivity;->getMessage(Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    move-object v0, v1

    .line 40
    invoke-static {v0}, Landroid/text/Html;->fromHtml(Ljava/lang/String;)Landroid/text/Spanned;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/sauce/androidchallenge/MainActivity;->showMessage(Landroid/text/Spanned;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 43
    .end local v0    # "message":Ljava/lang/String;
    goto :goto_0

    .line 41
    :catch_0
    move-exception v0

    .line 42
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 44
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method

.method private validateSecondIngredient(Ljava/lang/String;)Z
    .locals 2
    .param p1, "input"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 58
    invoke-static {p0}, Lcom/sauce/second/IngredientFinder;->find(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 59
    .local v0, "ingredient":Ljava/lang/String;
    invoke-static {v0, p1}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    return v1
.end method

.method private validateThirdIngredient(Ljava/lang/String;)Z
    .locals 2
    .param p1, "input"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 63
    invoke-static {p0}, Lcom/sauce/third/IngredientFinder;->find(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 64
    .local v0, "ingredient":Ljava/lang/String;
    invoke-static {v0, p1}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    return v1
.end method


# virtual methods
.method public synthetic lambda$onCreate$0$MainActivity(Landroid/view/View;)V
    .locals 0
    .param p1, "v"    # Landroid/view/View;

    .line 30
    invoke-direct {p0}, Lcom/sauce/androidchallenge/MainActivity;->validateIngredients()V

    .line 31
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .line 22
    invoke-super {p0, p1}, Landroidx/appcompat/app/AppCompatActivity;->onCreate(Landroid/os/Bundle;)V

    .line 23
    const v0, 0x7f0b001c

    invoke-virtual {p0, v0}, Lcom/sauce/androidchallenge/MainActivity;->setContentView(I)V

    .line 24
    const v0, 0x7f080100

    invoke-virtual {p0, v0}, Lcom/sauce/androidchallenge/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/sauce/androidchallenge/MainActivity;->messageText:Landroid/widget/TextView;

    .line 25
    const v0, 0x7f0800d7

    invoke-virtual {p0, v0}, Lcom/sauce/androidchallenge/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lcom/sauce/androidchallenge/MainActivity;->ingredient1:Landroid/widget/EditText;

    .line 26
    const v0, 0x7f0800d8

    invoke-virtual {p0, v0}, Lcom/sauce/androidchallenge/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lcom/sauce/androidchallenge/MainActivity;->ingredient2:Landroid/widget/EditText;

    .line 27
    const v0, 0x7f0800d9

    invoke-virtual {p0, v0}, Lcom/sauce/androidchallenge/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lcom/sauce/androidchallenge/MainActivity;->ingredient3:Landroid/widget/EditText;

    .line 29
    const v0, 0x7f08006b

    invoke-virtual {p0, v0}, Lcom/sauce/androidchallenge/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    new-instance v1, Lcom/sauce/androidchallenge/-$$Lambda$MainActivity$wXAEIgKRUHr85vlM-T9u4Bj6XJ0;

    invoke-direct {v1, p0}, Lcom/sauce/androidchallenge/-$$Lambda$MainActivity$wXAEIgKRUHr85vlM-T9u4Bj6XJ0;-><init>(Lcom/sauce/androidchallenge/MainActivity;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 32
    return-void
.end method
